Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A5E597F55
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420774; cv=none; b=jz7s01fkpO8w73Oi49zintLGYVhaiDqpzmn/HeQzXxFAhrVxTInwD5EntqZPcB3Lg03UXxs3J6CdZeJ+U3/lbzn8VIdZl9NfxwUfycIzgp2PiYy/Jvn90XG97C/HD6u4QI/nQhuF7TrNVzn/KXY0XTL1ygzwvU+azeuHz2pHf3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420774; c=relaxed/simple;
	bh=2h9UIOLonoKrDR56nbeC/nC3gznJkCFahloq+sP53xU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxorBpxr8/s8xk3BiujC5CfkCPRyzIATDWYvJmGxA/KV6oDVMo/mvICM+Yn8CPVWwOSElVxZLJJ6vca9fe1ETKgR5dWTIBRgStsYl733Lor8EpEBE8qNSP+nabquv4ucargtrRUpZWc8+f3bxR8odwg9b1IbxYMuu2VmnNmAv5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OM36+XGb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KmvGUby7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OM36+XGb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KmvGUby7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0ZHQ2774612
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Sb69aQPpuRDPIxY/hTHIVb/r+8ocignrD35XzySTbJg=; b=OM36+XGb92Zv1aKx
	jkn4DkAPA8yjiR67WxcpgheEbDLJx0FXCoLYgSPOJN1QLjV076ATYbpam0nIOJZT
	2iawdUFQfQktICkzmegT/hIqhSQfX4efdzGpZq1uLI0dU3TKud0oTTBR50eaICC+
	AFzYL8IHVyvqeCG2rpLuDWI0hGExTS3PzZ68Hxtg/vWwDcFGbtu5VYA053KVzKrx
	quTzLtGWTPk2Fo1KRV3QNNYpfwJJRKMLOTOJhW+8KI2mUfZj7M2DaBm1FS7Fdagd
	I8sJ9L1APaM2VpgZddKcbo19y4z++pKeSyJJRvH2olBG6BLfOj2woB9DwCcJ+KCn
	IoOhhw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur39nc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:32 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f322ef7d3so365873985a.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792420771; x=1793025571; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sb69aQPpuRDPIxY/hTHIVb/r+8ocignrD35XzySTbJg=;
        b=KmvGUby71i1v1nDEElYcWJ3+oZqC2mvZ9dGoYWt2YcBQY+Jwp91LLm8sco6BFvwjLj
         9y1KApZaa9RIUU3yMGwbaLp7bh2hEBQcfJ5bRICbVLpR5+hJ/AlIeIMOxCIHah9P/lrZ
         wsdLWedI6k9mMRs6zv6Jpy0DBE3c54aEN+xtK99Oz7XsZe4MsVqWEQioZ5AUWr8mvkWj
         Y/s4p1n+jUcJow4dHnlALyF3FYBlBCP/u3zuE4AEvNQpro7X/tuzukLTaJRsAP5NUzVp
         inwWoglq1Q5XkbJ3v9DkbVGJFKne59G9QovbD7c4KkazNqyzD3g5/2BMJ/D50ubIAkKL
         GMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420771; x=1793025571;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sb69aQPpuRDPIxY/hTHIVb/r+8ocignrD35XzySTbJg=;
        b=DxuDiRgSNF/eBJTI/nPIqjp4v9RGAyyZuAUCpT9X8fpDpFUwed4FNTUch8XAaiaSx5
         8LlCbXmC2LR72X9wWGJRKpYp1V5JJ/KcEj5yqAWkPtJyKRXabOqFbKPHp35nJdYd6WMn
         HYsYclOV34WYtzKMYdHgzYTo0m5LyKQRUyZU45igjStErVtXRfvyelYdaBCne4nkrGFE
         ObRLQuUJwKCDnJXyGFz2PbYQ54OmFAPsaEBBtq1X0loztfvdQXQuZnVAzIbYP+rHr3CW
         pUfm/BURuOxuTA8BzS2ZV8vH5ZeSbx3e8+tTPmE6VbkTafAdFJC6i2vMAME9+94S4vFQ
         7Rog==
X-Forwarded-Encrypted: i=1; AKwUvBy14HE+29WyH9B0kSg+8f4bl55DSXFW+O9xoxidIjJjGKFe7zlzKs9YiaGmhzxtNTiiCL5WTbjGLc24Mjk52g==@lists.linux.dev
X-Gm-Message-State: AFq9FYJfMMm838NpJaL41X3/yNtFw1e1bPzo1hA6j54+FQtZXsiWnoYp
	/rIvOdNs1RNWnLFh61KFZG/s3/s5O7UAaNN/anyB9u2wh32AfgS+t9zcxBb2wdt5tOG2Fb9ZCjD
	vWDnYXt9D11OWPiJqdjGKWSgnonQyiJcpE4Q93/Oi9HHuucAAFVJ2/9eUnrjzMstn0PJ1BQ==
X-Gm-Gg: AYBFou37bTlDa37WqM1F19hwEC0cROay5q1ShltgRnDnF9CY+QsMovwew013kUfS9b+
	nSZozYvufDC3dRITgSwJfzhHNhS1fkrxUUX7BaDhuDV6jBJxToTmMmhvz4Pagmj54jBkRp3eZNc
	jZN3SueuG0b53F+IKefkUTWNziCsGLh/qRlvzUDcaP+jasz8UNotKZAliW9x/qTstHoAR4cqj+1
	+eH8NfLv+paA2jdGDaLmuIrcBzQ/f2XBFsibD9aJxkAp5ZQHjys1XXdCJaTZMiZULCQXJJ8DDxV
	dz7EAfjQ5b1bQXW9ZObGMxX7vNX35jlsPDJj9iLPmOtuakpkNqGp7pcCc4qDfXo1wPU93ojTpPU
	5Kv9VPtQvWZ6LFhvTXAYmV81A7nXq1RbhyUplv88XWYRT8330bsaMJLlBWqXDcZcR87PMP9hBnd
	qnBacaX8biDepX
X-Received: by 2002:a05:620a:461e:b0:939:13a7:70f0 with SMTP id af79cd13be357-93f29b761e7mr1412810185a.5.1792420771378;
        Mon, 19 Oct 2026 07:39:31 -0700 (PDT)
X-Received: by 2002:a05:620a:461e:b0:939:13a7:70f0 with SMTP id af79cd13be357-93f29b761e7mr1412805685a.5.1792420770865;
        Mon, 19 Oct 2026 07:39:30 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a63aa17sm2033436e87.69.2026.10.19.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:39:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:39:20 +0300
Subject: [PATCH 2/3] soc: qcom: spm: don't clobber the SAW control
 registers
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-fix-qcom-saw-v1-2-9c7ba3fc2493@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1518;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2h9UIOLonoKrDR56nbeC/nC3gznJkCFahloq+sP53xU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iuZr/aD81SWq8mJzMNHpjxVB55R04VWteNk0
 Y97uu0Gvg2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYrmQAKCRCLPIo+Aiko
 1YSIB/46ChAYMr0agN2qErsuiZmDmS6wBDy8ppemc89S/ayPCF4/hy3nbwq0aUYs3x1JYVrKYsl
 J4df7tFxk70DF7He4fpVJlyVnQ2CKhSildPAVt20Z6EyQc0ONLntuSpM5pej9GYDJHL55t0+kCX
 3ZlQVVxId9wK1TA8Pc9WM57f8X6gBw//XZejTX/yPYAf2eLvsjt3nhd2NoTaP88a9WXmPR2coPY
 YITKHv5xEo05JvGLP6IZwfFNJ8NcTIfKVPTSi/Jk4Xu3FLwFAXxAecn4txVWiqRH9CbBoTtVLG5
 mH/sbX088dBHy/cTiVinbuTTKP7LSBYhJ/cxA7iIb3Oze8RO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX1SP9KME6Lp/I
 jYJ6R1PBR3rKkQTKOEszFhjvoKHyJt2Mu6LqclS02N/Wg11Jrn5a/d5nPnSG4Nm5/v5Jm3EljAW
 AVZllrE2+YpZBk+D53ZjOw0nlb/Xgrs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfXztS/btJ+IR6U
 wZxZwmJAfMgMVwMv2kTD8nMpLuweeMXtZutlBfZoq9vCg3XL5QVlWILumxt0ABs8LcFBFTOt2aB
 D1gEeAXDDHPdla0fnbxepwOrDBxyGkgtL3xVS+xHI0tNmJgFHQbPSwIyBPYd+IdnX7LeFCNMXg+
 mr9ARw4jfjPdcNyZ2Doq8bvIWAKsxK7tfMyHXyqaV4LexSMV9xGdnlPmOjVUqd7jrPoJupJ2upz
 y1tK+IDvlF9A3ADmqKSng4KhSx+aQ0HWpygwkg7Sjh0hiqrC6bQ9PRAPtl9ps2486tfuaMOJzu/
 r5C0+YIcCM5Ud7ue9P4VYfwUsaiW5EiCWpNlgcJ6dC0+OuL2fu3cOoZIVykTRhkr2djfemM2dpy
 NQmdXzWWKNRJetHA6CfpwVRycNvB7nrWYher5+5vcV1k9ISb5hMX6J7jB6vwLEduATqzFFhnZgv
 mh7lZxtQ8bGQApt6F4g==
X-Proofpoint-ORIG-GUID: Zp4PZXju-pN2pc05NiYSW2-kJ_v0B7wO
X-Proofpoint-GUID: Zp4PZXju-pN2pc05NiYSW2-kJ_v0B7wO
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad62ba4 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=lKJQq1FpCFxXXcX5SosA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190058

The SAWv4.1 and SAWv2.3 register tables have no sequence entry, so
probe copies the all-zero sequence buffer to offset 0 instead, wiping
the SPM_CTL, SPM_DLY and SAW_CFG values the boot firmware programmed.
On MSM8998 the firmware then still powers the gold cluster down once
its last CPU goes offline, but never brings it back: PSCI CPU_ON leaves
the first CPU pending and the SoC hangs or resets.

Only write the sequence when the SAW has a sequence entry, like the
other registers.

Fixes: 13e72c3e2261 ("soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/spm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index d41c94d32b51..6f2f14eb9022 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -528,9 +528,11 @@ static int spm_dev_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, drv);
 
 	/* Write the SPM sequences first.. */
-	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
-	__iowrite32_copy(addr, drv->reg_data->seq,
-			ARRAY_SIZE(drv->reg_data->seq) / 4);
+	if (drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY]) {
+		addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
+		__iowrite32_copy(addr, drv->reg_data->seq,
+				 ARRAY_SIZE(drv->reg_data->seq) / 4);
+	}
 
 	/*
 	 * ..and then the control registers.

-- 
2.47.3

