## Task 1.1

1. Install **Git** on **Ubuntu**
```commandline
sudo apt install git
```

2. Add **name** and **email**
```commandline
git config --global user.name "udorosh"
```
```commandline
git config --global user.email "rootdorosh@gmail.com"
```

3. My account on **GitHub** - **rootdorosh@gmail.com**


4. Add a new repo - **DevOps_online_Lviv_2021Q4**


5. Clone the repo to my workstation
```commandline
git clone https://github.com/udorosh/DevOps_online_Lviv_2021Q4.git
```

6. Go to the our project directory
```commandline
cd EPAM/DevOps_online_Lviv_2021Q4
```

7. Add a structure of repository
```commandline
mkdir m1/task1.1
```

9. Create **readme.txt** file
```commandline
touch readme.txt
```

10. Make init, add to staging area and commit with following commands
```commandline
git init
```
```commandline
git add .
```
```commandline
git commit -m "add a readme.txt file"
```

11. Create **develop** branch
```commandline
git branch develop
```
```commandline
git checkout develop
```
or shortly with one command
```commandline
git checkout -b develop
```

12. Create **index.html** file
```commandline
touch index.html
```
```commandline
git add .
```
```commandline
git commit -m "add empty index.html file"
```

13. Add a folder with images
```commandline
git checkout -b images
```
```commandline
mkdir images
```
```commandline
git add .
```
```commandline
git commit -m "add a folder with images"
```

14. Open **index.html** file
```commandline
nano index.html
```
and create simple webpage with photos
```html
<!DOCTYPE html>
<html>
<body>
<h3 align="center">images of nature</h3>
<div align="center">
        <img src="images/U5igIu.jpg" alt="img1"/>
    <p>img1</p>
</div>
<div align="center">
        <img src="images/Ezr3bQ.jpg" alt="img2"/>
    <p>img2</p>
</div>
<div align="center">
        <img src="images/c9pZKj.jpg" alt="img3"/>
    <p>img3</p>
</div>
<div align="center">
        <img src="images/25aeWl.jpg" alt="img4"/>
    <p>img4</p>
</div>
<div align="center">
        <img src="images/PF74mL.jpg" alt="img5"/>
    <p>img5</p>
</div>
<div align="center">
        <img src="images/AOQSbk.jpg" alt="img6"/>
    <p>img6</p>
</div>
<div align="center">
        <img src="images/lCrYML.jpg" alt="img7"/>
    <p>img7</p>
</div>
<div align="center">
        <img src="images/smHSK4.jpg" alt="img8"/>
    <p>img8</p>
</div>
<div align="center">
        <img src="images/PhDXdm.jpg" alt="img9"/>
    <p>img9</p>
</div>
<div align="center">
        <img src="images/EDZnQe.jpg" alt="img10"/>
    <p>img10</p>
</div>
<div align="center">
        <img src="images/okqBcx.jpg" alt="img11"/>
    <p>img11</p>
</div>
<div align="center">
        <img src="images/aeCr57.jpg" alt="img12"/>
    <p>img12</p>
</div>
</body>
</html>
```

15. Go to **develop** branch
```commandline
git checkout develop
```

16. Create **styles.css** file
```commandline
git checkout -b styles
```
```commandline
mkdir styles
```
Open **styles.css** file
```commandline
nano styles/styles.css
```
and add some styles for our webpage
```html
h2 {
    font-family: monospace;
}
img {
    width: 30%;
}
```

17. Attach a **styles.css** file
```commandline
git checkout images
```
Open **index.html** file
```commandline
nano index.html
```
and add this line of code
```html
<head>
    <link rel="stylesheet" href="styles/styles.css">
</head>
```
```commandline
git add .
```
```commandline
git commit -m "attach a styles.css file"
```

18. Go to **develop** branch
```commandline
git checkout develop
```
```commandline
git branch
```

19. Merge the branches
```commandline
git merge images
```
```commandline
git merge styles
```

21. Merge the **develop** branch into **master**
```commandline
git checkout master
```
```commandline
git merge develop
```

22. Inspect the repo
```commandline
git log
```

23. Push the project to **GitHub**
```commandline
git push origin --all
```

24. Execute **git reflog** command and save somewhere with filename **task1.1_GIT.txt** 
```commandline
git reflog > /home/udorosh/EPAM/task1.1_GIT.txt
```

25. Add **task1.1_GIT.txt** file to local repo
```commandline
mv /home/udorosh/EPAM/task1.1_GIT.txt /home/udorosh/EPAM/DevOps_online_Lviv_2021Q4/m1/task1.1/
```
and push in **GitHub** repo
```commandline
git add .
```
```commandline
git commit -m "add a task1.1_GIT.txt file"
```
```commandline
git push origin
```

## What is DevOps?

DevOps is a set of practices that combines software development (Dev) and IT operations (Ops). It aims to shorten the systems development life cycle and provide continuous delivery with high software quality.