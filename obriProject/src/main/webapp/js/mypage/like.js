let data = {
  prcareerCode: "all",
  prmajorCode: "all",
  prlocCode: "all",
  prhashCode: "all",
  stage: 0,
};

$("#btnSearch").click(() => {
  StringTest();
});

function buildWanted(likesWidget) {
  const pictureSrc = likesWidget.prFile
    ? `${path}/upload/${likesWidget.prFile}`
    : "https://picsum.photos/seed/picsum/200/300";

  return `<div class="wanted">
  <a href="prDetail.do?prNo=${likesWidget.prNo}">
        <div class="picture">
          <img src="${pictureSrc}">
        </div>
      <div class="wanted_text">
          <div class="text">
              <ul>
                  <li class="title">
                      <h2>${likesWidget.prSub}</h2>
                  </li>
                  <li class="content">
                      <p>${likesWidget.prText}</p>
                  </li>
              </ul>
          </div>
          <div class="company_intro">
              <p class="company_region">${likesWidget.prCareer}</p>
              <p class="company_name">${likesWidget.prMajor}</p>
          </div>
      </div>
  </a>
</div>`;
}

function StringTest() {
  let url = "?";
  url =
    url +
    "prmajorName=" +
    data.prmajorCode +
    "&" +
    "prcareerName=" +
    data.prcareerCode +
    "&" +
    "prlocName=" +
    data.prlocCode +
    "&" +
    "prhashName=" +
    data.prhashCode;
  // url 확인 차
  console.log(1, url);

  // ajax로 데이터 받음
  $.ajax("api_likeListsPR.do" + url, {
    type: "GET",
    dataType: "json",
    async: true,
  }).done((res) => {
    if (res.code == 1) {
      console.log(2, res);

      let likesWidgetList = res.data.likesListPRVOs;
      $("#wanteds").empty();
      likesWidgetList.forEach((likesWidget) => {
        console.log("likesWidgetList for each문 실행");
        $("#wanteds").prepend(buildWanted(likesWidget));
      });
      alert("데이터 검색 성공");
      //location.href = "/api/wanteds" + queryString;
    } else {
      alert("데이터 검색 실패");
    }
  });
}

function ChangeValue(id) {
  let element = document.getElementById(id);
  if (id == "prcareerCode") {
    data.prcareerCode = element.options[element.selectedIndex].value;
  }
  if (id == "prmajorCode") {
    data.prmajorCode = element.options[element.selectedIndex].value;
  }
  if (id == "prlocCode") {
    data.prlocCode = element.options[element.selectedIndex].value;
  }
  if (id == "prhashCode") {
    data.prhashCode = element.options[element.selectedIndex].value;
  }
}

// function showSkillbutton(id, name, text) {
//   document.getElementById(name).textContent = text;

//   const btn = document.getElementById(id);
//   btn.style.display = "flex";
// }

// function hideSkillbutton(id, name) {
//   const btn1 = document.getElementById(id);
//   btn1.style.display = "none";

//   if (id == "skill1") {
//     data.skillsCode.splice(0);
//   } else if (id == "skill2") {
//     data.skillsCode.splice(1);
//   } else {
//     data.skillsCode.splice(2);
//   }
// }
