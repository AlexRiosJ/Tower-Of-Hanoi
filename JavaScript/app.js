let tower1 = [7, 6, 5, 4, 3, 2, 1, 0];
let tower2 = [];
let tower3 = [];

function moveTower(disk, source, dest, spare) {
    if(disk == 0) {
        dest.push(source.pop());
    } else {
        moveTower(disk - 1, source, spare, dest);
        dest.push(source.pop());
        moveTower(disk - 1, spare, dest, source);
    }
}

console.log(tower1);
console.log(tower2);
console.log(tower3);
console.log('');

moveTower(tower1[0], tower1, tower3, tower2);

console.log(tower1);
console.log(tower2);
console.log(tower3);