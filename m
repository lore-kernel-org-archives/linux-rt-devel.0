Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85C1597F37
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420771; cv=none; b=Czek/Og4b3182ehpx24qzocT+LZ5weAMCyZOBY7bi6JKWhJk8C14RujI743WPC29iqo+8uc7DokVWyqzHLuCL17znvTEZMbP8WLpwMciJTza7hXZkOik2Hl3K0OmuQYbt2BxkBE8POMLnAgBPRjWAPEA+qbVtZ7/pKlrLiEryuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420771; c=relaxed/simple;
	bh=2TstF2SND7fE5Rmpoe3pXhm/sLFsTBxNKrPB1QGiNNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CLXZkM9cGKiyBq5X4bL1QdTdIwbCEsg3yO+Ve0Uws0f9gUtEiM1WVTShMgDU1+ZjecVbPOROrYap2tmRdlAECEvrtBJ3aBfmk+RSStEIL8Amf3xhyng1PQZm3Ae+3zPZ6Zv+MWretjZdpEnCbq+Ew7dFl8gCtkgXSA8KLKorbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l9YrcygU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iJVYH0e0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l9YrcygU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iJVYH0e0"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0IIm2971616
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jjCx6/yxQC9ysAu05r7/WSvftYtqgg6wz8K+mhMEd3Y=; b=l9YrcygUhwTOQ7Nh
	dIfPh1Rqcqm/o61WYYUob87U8BJKaWt5z9SDXZbf0Tf9HP927GzUK4JdswuzQAdb
	RfD7IYMit8s+zxKj6YllVlzBCj85G0FMpfkpkTTl/FBJGQvCLxggMMg3ighYdG9k
	IXaG7qDAa0p40DpRJxnb4EUOvRlXVnpgO1/Lx3PrX4yQmVjJs6hnIyEr3eYGJVVE
	raURo14CaXMdg4ucLH+u/YvLpW22kRoyfrkbamGQgTbg0NYLOKSDUz4FmT20Fc4p
	tQadOG6QiSZs880h3oO+NSHDrRFixU+RJkCpkHxdw7RkpmrE7rT5nB1udDc9fSby
	KZz1JQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3x9q2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9308eafb465so686638885a.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792420768; x=1793025568; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jjCx6/yxQC9ysAu05r7/WSvftYtqgg6wz8K+mhMEd3Y=;
        b=iJVYH0e0KMZ2YoGgSBKrBIA1hp/OWACo0w973QpJSHjEDWTLmgvZmoHNPhwv9+uuKg
         npP9C8bYcR1HukiLEZB/wbX0ZnvH2JE3zCEiriDc5Q7gtgK2B92tj4Vrf7bG5oT7kGsS
         7FtfN3ND2bAsGi+/jqpyqnRkGTG1ekaIaAkia32ArGE/EsWiNw5bURNWAGEZCYpvwQWe
         DyIExwavUcqUbsgXiA+EHA6Yy/CLXbPqVoft9tdfW2KYIipYC/dai1aRpx6iYZwtlrJ7
         hESdCTejJeO6Mom0vGozBKToQUhNrihSAIrAld85B5bqxrvFMXuHEj2gP6kgU8xn6/W9
         QkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420768; x=1793025568;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjCx6/yxQC9ysAu05r7/WSvftYtqgg6wz8K+mhMEd3Y=;
        b=UJIPpGWPONnKxA43fuxW8Y5Jb2uUdT388r+8U4aKqlXuY6ZYIG0pVrPwAz2AZYI5m9
         y1/KGZsCBKjcVn/ial9xB4DIlLEJpcthzlaUx04pQ5Z2LQMMDKqmCfvZUits9N9vF0OI
         +3U9OreZM3QqfCefMahhaj7kU4SZLcUnlMuVy8Kt4nzLxd9c4IovGigH790VMlW+mBO/
         qarp0PunlnF6BBJCbDx+WBMF6KU+DdUlSmTFtzltFSHBQ44zpLGAosEGHbx5v9zJc3sV
         I9dKbaNnf7ltE/hewdhlrlV2xzga/zODxfbU+NBNTILo3Z+BerdrBh1vK1pjI7ETad8p
         NicA==
X-Forwarded-Encrypted: i=1; AKwUvBxIXBH9DF0cnwLpsSao68ks8XxrQXCNbb2tpH+8gG8JnZKMGzI8ujGiH5YeLjBJYMOODSEf0ys5llLg16/2tQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYIbSdsEtCyr6MeUO6tAld1gEJYYz5E6z9eqUo0seKNJX9H7THrS
	4Vh3BfJva9b04hp9YwW4HsRKAbkHx9QzxChGzIBW/TxuR4mw/bdmn9FzM7xf71PcUnTsVwOJvxt
	/45k0hpr+bOa9bE4BseFcZO5B4UrI6MqZ5j3oiUALVWllzBWSuWIftyvILS8wNuWYuloO1A==
X-Gm-Gg: AYBFou0lFHYJ5tyORc9uNPWojWm6bs1EP5C0bw5ynx5nC9A1uXpUzetBzp4FjRyeizh
	UUI/bbmZgPuLV6ZQUwpOWLhz+ZDtAeocTD9O5V5Ac9AhCD3n2PaDO+/W99JFvJUs4qFAN/IfqjQ
	aSedOH6kKq9wfEPqUkgauMUWp4SFraG3Rg4HfXSNJF++bHt77vPoVK11yZJ4UtHR6b0XRsabAwY
	a4Voo2nQhZ/QP6VTIjcj7VtXBalw+qvbsLh09JX4WfXlDcJGKzSgCwTp/yDCq/+ZtsfYNdYqz9K
	Gf6dUnHFSI10N5BUzLjAOKn4LoBuIoFWQixYCo/FosZqIQ46WJ3IGplA2+5/lFvVstlrqGSaV2V
	71RVlTdCSf3W8XFN4/8rvSRRDkViv2E1M9AV8TVFXuEY0dfDeKlsJIBioeJi/NthYYwk6lrmaBY
	Lg1B8Bt7l5ibEE
X-Received: by 2002:a05:620a:800b:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-93f29dfd65emr1413394085a.81.1792420767824;
        Mon, 19 Oct 2026 07:39:27 -0700 (PDT)
X-Received: by 2002:a05:620a:800b:b0:93e:c12c:fbc4 with SMTP id af79cd13be357-93f29dfd65emr1413390585a.81.1792420767337;
        Mon, 19 Oct 2026 07:39:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a63aa17sm2033436e87.69.2026.10.19.07.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:39:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:39:19 +0300
Subject: [PATCH 1/3] soc: qcom: spm: fix the SDM660 silver L2 AVS control
 value
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-fix-qcom-saw-v1-1-9c7ba3fc2493@oss.qualcomm.com>
References: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
In-Reply-To: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=926;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2TstF2SND7fE5Rmpoe3pXhm/sLFsTBxNKrPB1QGiNNc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iuY6bpLJierCag4dK6Bzw0D+amcMWhxQzKVA
 ekR1qbYYxOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYrmAAKCRCLPIo+Aiko
 1TCeCACYOrLf7U90MxlU0YEzW5lPoqIkDGGPtNFxF3pj25nPJP87GC1fQ0atHxRs2OYMOW6xNJr
 85es0hWWsfWFsDsuVqJ4FxC4jfvBVvdwjoYn89sx9qTKupzypWL7hs5vR38O4DEowjwQeQB8MiS
 CoG8Ovbov2o2JjZiVuEO9avi0ikZXgwt9dfrS8oC8hv7r5TxwciIYg3TtPjjAn972S1AEXxVI6I
 M6Ks0xiDGIuxc/I6U0ffFbFs2RyvtBGnNg0xPHIH+b+5/UYiui59bIwdptcw0mYzdK6JMjLaSpm
 chJv0Mos+ThFMteCx7EWY0+lwJiVhBBSdm05xyEtofSp+Gzm
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: O-NIXtvz69w2SmdYNCUE-PzZ50jmAKmR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfXzhgu+0RBQc+c
 GUhKdF57eKU1ZTg0iWeY2ydbA6byJRvCeBTQq5MjRSh1VM7GZMj01tUDTdSf5yWbKbGYaUUR/bM
 lzRpl0SgXhJfNeFhi+xtRGUf2ZyDI2U=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad62ba0 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qlPoGPJu3atbak1x7WIA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: O-NIXtvz69w2SmdYNCUE-PzZ50jmAKmR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX4DguGfImRZ/d
 HPDeJTTyBIgdLKeBNTNMsguSqLPu4IzVWd1SVF9Ws5VLsZpAUr4HyL/d1iXIUYy0lOM5wOb7znR
 fJNz2NHuuT/dUOG3y3qwMcmGMzhYclQqz43vu41g1Jh5C3BZy2gmG6+mU+7b+QXaeFnv/l/f7H+
 VBouqv1qQbRyvNwUVnwxwRFJxteAE4IENlPkj7TKehnXEH6tw4fvT7TPnF3VB1w5kxRo5vzA6Xf
 qaHbx/ytMGcr9neAORO4241L1FKQAH1hTJvNzuIQUaweN3eOk01Vq9hjG1ORPq9tnTsDwHABsih
 40JFANRIoL/gxM3b5XMIj/ZEQMGDyPdBfbkyIu07gckVwEA7YDzqE7GJf6iWcSqX1j/QMEaZc3X
 lVLDFNLU2wWVK3MnA0km+QKARgpkdAqv+CeLrcceSmkSApTfRQR9hTtlhqxcG8rkoum4YU6ezXQ
 q2tgngiqCPYZL+1V5hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190058

The power cluster L2 SAW of SDM660 is programmed with an AVS control
value that differs from the one the vendor kernel uses for this SAW
(0x1010031), so the AVS hardware runs with the wrong configuration.

Use the vendor value.

Fixes: 13e72c3e2261 ("soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/spm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index f75659fff287..d41c94d32b51 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -100,7 +100,7 @@ static const struct spm_reg_data spm_reg_660_gold_l2  = {
 
 static const struct spm_reg_data spm_reg_660_silver_l2  = {
 	.reg_offset = spm_reg_offset_v4_1,
-	.avs_ctl = 0x101c031,
+	.avs_ctl = 0x1010031,
 	.avs_limit = 0x4580458,
 };
 

-- 
2.47.3

