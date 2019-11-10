import { Component } from '@angular/core';
import { createWorker } from 'tesseract.js';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  public ocrResult = '';
  public link = '';
  public progress = 0;
  public loading;
  public mfile = null;
  public l = 0;
  public top = [];
  constructor() {
    this.loading = null;
    // this.doOCR();
  }

  async doOCR() {
    this.loading = true;
    this.ocrResult = '';
    this.progress = 0;
    this.top = [];
    this.link = 'data:image/jpeg;base64,' + btoa(this.mfile);
    const worker = createWorker({
      logger: m => {
        // console.log(m);
        if (m.status === 'recognizing text') {
          this.progress = m.progress * 100;
        }
      },
    });
    await worker.load();
    await worker.loadLanguage('eng');
    await worker.initialize('eng');
    const { data: { words, lines } } = await worker.recognize(this.mfile);

    this.loading = false;

    this.l = lines.length;

    await lines.forEach(l => {
      this.ocrResult += l.text;
    });

    let topWords = [];
    let topValues = [];

    await words.forEach(w => {
      if (topWords.includes(w.text)) {
        const index = topWords.indexOf(w.text);
        topValues[index]++;
      } else {
        topWords.push(w.text);
        topValues.push(1);
      }
    });

    const ln = topValues.length;
    for (let i = 0; i < ln - 1; i++) {
      for (let j = i + 1; j < ln; j++) {
        const a = topValues[i];
        const aa = topWords[i];
        const b = topValues[j];
        const bb = topWords[j];
        if (b > a) {
          topValues[j] = a;
          topWords[j] = aa;
          topValues[i] = b;
          topWords[i] = bb;
          i = 0;
        }
      }
    }

    topValues = topValues.slice(0, 7);
    topWords = topWords.slice(0, 7);

    for (let i = 0; i < 7; i++) {
      await this.top.push([topWords[i], topValues[i]]);
    }

    await worker.terminate();
  }
  onFileChanged(event) {
    const file = event.target.files[0];
    const reader = new FileReader();
    reader.onload = ((theFile) => {
      return (e) => {
        document.getElementById('list').innerHTML = ['<img src="', e.target.result, '" title="', theFile.name, '" width="50%" />'].join('');
      };
    })(file);
    reader.readAsDataURL(file);
    // console.log(file);
    this.mfile = file;
    // this.doOCR();
  }
}
