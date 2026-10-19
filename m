Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF88597F2D
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420769; cv=none; b=dpln8Ylarnu4NncCPTs5bfjV0qGpGpL5P1kN4iDtS2nN8fIEbwTJS+pOXZ+yC/sGCAsAkXtbEPk8kqB4p2cTzJqAFmR7aChgpK/CsoVuPv+mSs8d4g9qOTc+SQlfdcwvM1yMPFY0xiurbw+BAhfA5AM5Rs0Efy89oSwlbsZul88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420769; c=relaxed/simple;
	bh=BK0a94vpBIqq+Gxmo6AjIyQcf/Pq7YHz9PAFVnNn7/w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CRR2kOxWU27bIQg02c3SauvUPGWbRIpJqlkLGvnw/QlPSDRtK6iCZdQg9/3ofCiY8SmWw0OhimFHsHYLO8Dx2IQRzsvdzdcig8jOML/Qo9N2qOYl+I7nqf1NX5r0eYPQ80oye2db+Bix4lKwEb0MhI81JjZFAW4WOwbN2VNM3do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Roc6lFKI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PLjsmoBD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Roc6lFKI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PLjsmoBD"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0BPi3990283
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XPPtczvSoEHhQY+cig7W/K
	qPdn1W/lyGMJa9A5JB7s8=; b=Roc6lFKIzuPtgF+hMjzXBapJDNv107XVjqlzWj
	st58SXh6HtsKbg+/fw6Gb/buLevJbduJxFMNpGi0/RZ4bCCUBRV2niW/SMuG5por
	9mQ3ssw6JJzlUhvhdPZxs174rGQUlH7EnQMnmX8dsNNEZmWYimAOZiEuC1k6gWIZ
	LbyzrRUhLCd7kM36F99i3EvubRGQyxGXNl7E9ZAkDjYiDOiThU7m5ALEnqGuJ8LC
	47sHCXccLZcGgiW+rTdJ63hXcZqAyByIDpLzP6H750wTAWbN+06WTluLBJoB871g
	sXC0Yor3CwbhnFYa79LtdD5XoJ9JoOMtAkPBDQTNnUla4P/A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f9p05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f1e62510cso532251285a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792420766; x=1793025566; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XPPtczvSoEHhQY+cig7W/KqPdn1W/lyGMJa9A5JB7s8=;
        b=PLjsmoBDuIRGG1qtEPWCWryVQgtcuUiLdH8E2yVXBsjyAlEdKclERocVT7O5zFmE7I
         wNGz3jpKBk+10Yn08z+dmBFY84h3TJodrxe8hav6uZNJIZ3M8t+ilnSwVwbUu4uQu+6j
         WXVZcOzr5Frelo5tfox/Cy4aVL43mrK6cIBQN3hNj72BwAoe9DvSAG7LV8zS/Q9932Ez
         5KNb1TBHKBPtFUstMLRz1pZbsv1OgDR6kwKno0XkmjqxGxdJRMkcvXAi/RNYfi1uAzEm
         Fioj6VPnS+/vQ6Tk3X/ObjJbAl/wuGt2TGLhYpKKaLjXsdyFoX4csWmdug0ZPqoHLh4R
         jTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420766; x=1793025566;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XPPtczvSoEHhQY+cig7W/KqPdn1W/lyGMJa9A5JB7s8=;
        b=NqGSjzJu9pULKf6woFIZ+yFTaL1rfq1YPzwimt9mE5Z6uRGM5r/A5iMWz8fp74qema
         iDM1TH+bB+2AcaGCXhjHT3UR7BzhSEc95VoP3H6vvxlYKfyAXxkgyiGAO+1u8W7F46ly
         MlqghDl6Kfre8sF+QPiRiVID6DKtcEuMh3VpxnUs7R+SfgKSz1wkl7ekWlAtqxXVtoJ6
         PwcALJqU33d17f1kNYGBt8aeuiLhpiERqvUAF4QVSUV4NM2UQnyHNXzhrKKoFYl6pvnX
         ySLDQDURrauGCKEP0WLr/iM/Ap+zj1Doqn4Lh6DD9bXldpCasmbFEh6f/vJ6whJq3BSZ
         sYOw==
X-Forwarded-Encrypted: i=1; AKwUvBwp7WdxuN3ON9DHk++YLu6lr8Q8vARzvYGZ6hUmbOiEGzarrrvm7cYbVyEVfarBfYENH1CixzEAb7IDzi40kA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIQULFQUa/KiKigAe5Ng3gBtdCXcyZt4Pmxo5jlJf2axCSdz1wt
	JUtabBnGsMRKYJ1nMcRixcnktH9/jY0GthLweLsJnit268wUHebQjLXvgGpdAPlyWcBJUtp04Dr
	IBPpyMo3Uczy3O/J4dJ4yHb7H573gxkx8lyrAn4G1ge8C5Guo5T5ZYd9mz8ZMCUo4goTVBw==
X-Gm-Gg: AYBFou02JqWoWgOXD8GLfELaZPdBFfz2jIMjGyesMoa5N0uhPFTdgvr17e+LEonKLW4
	BYtU4Dl2cjzV8cHUYznPXPFPXYei+b1P58LdPhehUIjF1RqaqeghvGDqOgC9hbS0j1HjCiKqCp5
	tQsuQmcHckfxptDFYqnHW3RyXg/8/WBb+0m9foJhR0psda4pJAnU6B2Hsv7INNIEDBwGsP1nrRd
	kviOVTaJATDY1FVd6LLdy+Lq+6mv7nblxDQ4ZxNNfdPQApiJY+oBjzGhHtFv80RcE2eQv6gWAaL
	/iDdBPpjToACESPSNzeUDPMSdYi5iMGspjTUseyBX6humnw+kulEadcINpQRpnEOiMVVqnvRK7a
	GNfKpI9qtyLdYCOLWHjXW3d8LU9BO8CMv6ELuYn1e7NGGXAvy5UwQpW5dKnFA13fOQmlnmfC9r1
	pkMJfSvmIFIAip
X-Received: by 2002:a05:620a:460d:b0:93e:c12c:9b6c with SMTP id af79cd13be357-93f29dcd9eemr1253700785a.71.1792420765989;
        Mon, 19 Oct 2026 07:39:25 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:93e:c12c:9b6c with SMTP id af79cd13be357-93f29dcd9eemr1253697085a.71.1792420765536;
        Mon, 19 Oct 2026 07:39:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a63aa17sm2033436e87.69.2026.10.19.07.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:39:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] soc: qcom: several fixes for SAW handling
Date: Mon, 19 Oct 2026 17:39:18 +0300
Message-Id: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJcr1moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0NL3bTMCt3C5Pxc3eLEct1Uc6M0S+NUEwNLS0MloJaColSgPNi46Fg
 Iv7g0KSs1uQRkhlJtLQAhVRrecAAAAA==
X-Change-ID: 20261019-fix-qcom-saw-e72f93e40991
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephan Gerhold <stephan@gerhold.net>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ilia Lin <ilialin@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=890;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BK0a94vpBIqq+Gxmo6AjIyQcf/Pq7YHz9PAFVnNn7/w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iuYzRVL0ke5C33T1RCmCyShLjhc6mUBz32Aq
 ewKg4KUL3KJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYrmAAKCRCLPIo+Aiko
 1QnoB/9eg0scekKTAPMUeSZCqAnsQL/zdctCrGvIJVOBndJQU/FgISZGKU5P4+frLT8ziSGDmts
 3vvrXdyce5JBeYB3ykwL0JxVROy3a+mONoFoa15ayN3wh+Kv8N92dU6UikOYqszgSOjSyVMBbtz
 rJEEqvquWyfsHIooInqpg/8g09xaATcAMnejw8EecsddLjbquUdliCxjD6LRvz9QD1d6EgAH1VW
 6AHI5FZ/Q+EUmA0tUPZ1iFumCZ92chlzlSPnlVfMlbCnp/5WS4q0kK4F0R6T5cVefas0b97jshI
 KyQwK4A5x2ce16mgKUys+S5cdYYo8wBMHJDDGZC42KM1bmdP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: euU-Q7SeFf-MWbQ6kgKiNQ6BHl8H4Ps4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX1wmdxlvl+haN
 MjcKy+A4JqPg/+FHMURbAox5/jvbDS7m7eXg+nUBevtxHGuqEiKvw/To6QLBZjkdofnqJ7jRHrn
 rXztrkJ1sRBfO7xyRJwswKcN2yXqEDeGbvMJTIFO2TOxMKWPtC40FrQ6a0KGM/ptL24myqmrs7k
 KkhnVMfgT8z9BfhF30I53yUHaL+hmkG8mgun6HDTlcLd2xfXAY3f/WireYmNL1azivEcgpuMP9k
 h9Wdo1NyZpCiP1FHX027Rq0+FaDN3lesgVedQoz9vQ0NQz1Oz+3kPNpnuCZ7O7SeSJNGGDIj+iO
 eqzi+X/VnPWS4juZUANopfQS1nmbmjD7FLpflJIhqbiOLdyL5wqL1QrBdtv/+uvqQV9CZWVLupK
 ysBZurj/2yVwftLot0qmwHEwJmkVtYBVHLGnRDzN8dYdeg5txnFoQzPpKq5L/H/psvST4p2Crsu
 BDb/jUXyLjG7KfU8hBw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX5SmLckTLu9MZ
 NFI2c1Iscd7dsO/OzFEae3UZtnbiRxzCfQCrx/0gs+wncxGxVhZy5HWjKQ0Sn3SN4LaLw5w/qQo
 JzmbN5dLeDxmselU4dmxw/Ckkknue0I=
X-Proofpoint-GUID: euU-Q7SeFf-MWbQ6kgKiNQ6BHl8H4Ps4
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad62b9f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=Tsnwx_13wjLmqCL3704A:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190058

The Qualcomm MSM8996 / MSM8998 / SDM660 platforms use SPM / SAW core to
handle lower-power modes and to program core voltage regulators. Apply
several small fixes to drivers for that core.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      soc: qcom: spm: fix the SDM660 silver L2 AVS control value
      soc: qcom: spm: don't clobber the SAW control registers
      regulator: qcom_spmi: don't take a sleeping lock in the SAW IPI

 drivers/regulator/Kconfig               |  1 +
 drivers/regulator/qcom_spmi-regulator.c | 35 +++++++++++++++++++++++++--------
 drivers/soc/qcom/spm.c                  | 10 ++++++----
 3 files changed, 34 insertions(+), 12 deletions(-)
---
base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64
change-id: 20261019-fix-qcom-saw-e72f93e40991

Best regards,
--  
With best wishes
Dmitry

