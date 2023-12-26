
document.querySelector("#btn-celeb").addEventListener("click", (e) =>{
    $.ajax({
        url : `${contextPath}/json/celeb/findAll`,
        success(celebs){
            // 응답받은 json 데이터를 파싱(JSON.parse)후 js객체로 반환해줌.
            console.log(celebs);
            const tbody = document.querySelector("#celebs tbody");
            tbody.innerHTML = '';

            celebs.forEach(({id, name, profile, type}) => {
                tbody.innerHTML += `
                    <tr>
                        <td>${id}</td>
                        <td><img src="${contextPath}/images/celeb/${profile}" alt=""></td>
                        <td>${name}</td>
                        <td>${type}</td>
                        <td><button>수정</button></td>
                        <td><button>삭제</button></td>
                    </t>`;
            })
        }
    });
});

/**
 * 폼을 동기적으로 제출하는 것을 방지
 */
document.celebSearchFrm.addEventListener('sumbmit', (e) => e.preventDefault());

document.querySelector("#btn-celeb-search").addEventListener('click', () => {
    const id = document.celebSearchFrm.id;
    console.log(id.value);

    $.ajax({
        url: `${contextPath}/json/celeb/findById`,
        data :{
            id: id.value
        },
        success(celeb){
            console.log(celeb);
            if(celeb){
                const {id, name ,profile, type} = celeb;
                const table = document.querySelector("table#celeb");
                table.querySelector(".celeb-id").innerHTML = id;
                table.querySelector(".celeb-profile").innerHTML = `<img src="${contextPath}/images/celeb/${profile}"/>`;
                table.querySelector(".celeb-name").innerHTML = name;
                table.querySelector(".celeb-type").innerHTML = type;
            }
            else {
                alert('해당하는 Celeb이 없습니다. 🥲');
            }
        },
        complete(){
            document.celebSearchFrm.reset();
        }
    })
});

/**
 * submit버튼을 눌러 submit이벤트 발생하지만,
 * 폼제출(동기적)이 아닌 비동기적으로 요청처리
 *
 * 비동기 파일업로드
 * - method=post
 * - form[enctype=multipart/form-data]에 상응하는 jQuery.ajax 설정
 *      - FormData객체 상용
 *      - contentType : false
 *      - processData : false
 */
document.celebRegisterFrm.addEventListener("submit", (e) => {
    e.preventDefault(); // 동기적 제출방지

    const frm = e.target;
    const frmData = new FormData(frm); // input태그의 사용자입력값 모두 등록

    $.ajax( {
        url: `${contextPath}/json/celeb/register`,
        method: "post",
        data: frmData,
        contentType: false, // 기본값 application/x-www-form-urlencoded 처리하지 않음.
        processData: false, // 직렬화처리하지 않고, multipart로 처리
        success(response){
            console.log(response);
            const {msg} = response;
            alert(msg);
        },
        complete() {
            frm.reset();
        }
    })
});