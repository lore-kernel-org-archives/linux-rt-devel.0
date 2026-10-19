Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B643859A1CD
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420778; cv=none; b=BlS/qKZX0boztICT3DUPgh9pLfQD3+bYAp5FS8ajxaZmVT1YZTx3FTR2aKnzWVi8iK1RmTRmy7RXS/1g5S+MwSam8uP8579wRcvIaiV1XnwJstWTgZiemAY5APi/T6j1nsmC2O9pCResCwI/rYn4FqkYX1wnglrXsEPFdAdT3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420778; c=relaxed/simple;
	bh=W88aFyXLVL2s6jefU+R6NEkeW5WeUYxK4fu61wyaQLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sJLDc8+hgxFU8bcr/5RqdTM/2fs3mswnLUikgO5qPU507CZm8rF3yN5wcd0kmNsX3OF40SRYDnTza3ZNrtyqaSGug9d+3J9U8uT9lLD2rGfKgW9UhQoCnDYhabQQSjp9vUdrfnP3BVdFP71wwK0t1RIXD/lTUKvvn7d3XZeLhIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IN3hRBxa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aIhPh+a/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IN3hRBxa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aIhPh+a/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0VHG2774460
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	seWH79pPmvjDQRYnMxX62IYmBu0NmcGCDHCEkLyHmhk=; b=IN3hRBxaWfM8zoOl
	a85MCSkfA/xZnluqWAKlufnyTVGnsVpGD5533TUydIB4rf8gVKVPu6C3y7WAesS/
	+UJ2xLUEtxDvndh4mtoianrM+O7wXTlxLqL9FmJ5QhvtqJs9C/geC36pzd0GtPde
	0CiC7FpQfiI312Jug9S8EMyUm9wqryOidGhyDADXuSol7J8WLdZWCLjfPgmrzhKN
	j6p5ImOSvDRZJ4FHwStUD5CxuoT9iQPRYD4JviZRa2kExQn029+TzHuX4yU3OQnG
	jl8LHFhFip+HEhW43s9GAMIY/c3Jrpd/zKqn27VJTpp/gov6F/Qb/czvCZWXNiqk
	DpNRwA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5ur39nn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 14:39:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f13c143c8so415836585a.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792420775; x=1793025575; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=seWH79pPmvjDQRYnMxX62IYmBu0NmcGCDHCEkLyHmhk=;
        b=aIhPh+a/NZDus7tPhh3ZhxTjEyUENMs0jgjYx3Y4cje3QoziAcGO8m2IIBT8EJP8tO
         Soop7/wreH8K8z2+VyFQFwrftaxQH8tbwCwB/2Kq+7h8ZmS/kGycF07b3T5ktR1rl2SC
         PhL3b1rO6D7nmJ3GYm5vaesfiW/Qp9hBGt+/1okvXKtqEF+e1m9rkm9O6Vd/rElwxIeA
         wFUA25NcSFyXHlW7UmyoaAZtai35oJxmDbWViWC1BaqM1tvHGm7syiJ+WCRN8LBAouSJ
         OLAY1/Lk0XRbabA+G1sRbL/Xv+frIOwSQwop3J24cwd9iFhjRDrfWUIiqnIQOfATEe7j
         s5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792420775; x=1793025575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seWH79pPmvjDQRYnMxX62IYmBu0NmcGCDHCEkLyHmhk=;
        b=0J/QYxOTNc79vbb3gitLhjNpAaEq7gl44rb0tMC3LcehMfYDBouPPqOsF3crBRI/Ti
         E7YBhFvhKzBs6y8h9LROhqENxELHO5n44psqDi73jCsey12tCOyN+jQcyz9MQEZjEs13
         gpSEqnjaU8561mupXRus/0VDcC1P132HO0IB+LM1HZtrx0v9etLnbL2C1+SWvvpqNGiW
         +FvL2G7qB7AnmpZLP0lvuYPktd94m74Kw71CPK/hnzgIiZ0Uh2BIDLOvcmTBMtq4Gyuo
         ji9eKbPNg7DqlFNiccIrwXhKc/PvH7yis9qOkG0cu4K8JlxIPWXrf8BwkKvdkdhDyOWZ
         7Yew==
X-Forwarded-Encrypted: i=1; AKwUvByE6mRcieJo/ku4Jy9X1QKTHbUZzyZoQxbNhgTeuGXGPaQBD5S4QD0Yol6HyyGUsfyB3Jrs1Sy0JADuKGfczw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJVxzASwdScNnt38uHcLZ0MTCSTf9t1BDkYTHWFpKZUSUJxzJAh
	oqp6rIgpyQp9mOxqaLz1BZ+a2jDrkiNsO57bgna4UX50Tko6PMvWReVXMuKyMuKB6LvAuyVYdsH
	/R2yzgJI4+w6G0eTCWpX3L0BhcrEt0EOcbUd1GLcq7LUWHvpWgfQjR6Hia86B8KI8Xh3PGQ==
X-Gm-Gg: AYBFou23J301VIwT02p+VWdXycf/0ZImIcJcOcoy0JPfj55AovTZKwDC72NhAtxs+a6
	yE6fZ9DPe7EOuFqII2dL8ni0o1lCanGft6TvENHHDEfkT2yod1QkRififyNOmak6fa56G+dMvJ0
	X7zpj6mbv39w1HG7WAJ2o0zXSe27OLz186fWqYE8SgWuOEZfvULV2lLc8imBiV9NR7Q7G6lLmf+
	+ZVF10dUuWjaKX5X+gDaYJegPol2WZjXAUy7JIpvHqS/F8JrjbLXQskKEPKyd3c4lbUOQ20qLGF
	LtKzAn1RSVB4hyDVX1t1J6N/30IwD/nQxAiip2cN5ewfd3pEr0xNqAtN6lo4M2yQJTu/yQ8Io0C
	iS1kpZvUCAxjUeBHMWfjNd2tGk7ywLtqv3bqxAKVaFAdntczQwKU8iBmEEY4vFukdYOoqE5pIYk
	vMKxdtl1c30qi2
X-Received: by 2002:a05:620a:288d:b0:939:c1d4:e2e1 with SMTP id af79cd13be357-93f29cc979fmr1361950885a.25.1792420774775;
        Mon, 19 Oct 2026 07:39:34 -0700 (PDT)
X-Received: by 2002:a05:620a:288d:b0:939:c1d4:e2e1 with SMTP id af79cd13be357-93f29cc979fmr1361944085a.25.1792420774130;
        Mon, 19 Oct 2026 07:39:34 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a63aa17sm2033436e87.69.2026.10.19.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:39:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:39:21 +0300
Subject: [PATCH 3/3] regulator: qcom_spmi: don't take a sleeping lock in
 the SAW IPI
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-fix-qcom-saw-v1-3-9c7ba3fc2493@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3759;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=W88aFyXLVL2s6jefU+R6NEkeW5WeUYxK4fu61wyaQLI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq1iuZtT0j4U+vB60NcH0N6Mt6dwmk9o+rrkmzd
 aZqq2RrKV+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatYrmQAKCRCLPIo+Aiko
 1e4WB/9NOR1ZG4GiaNnX3KgtFpggU+x2+0DyhdeGzSrb+MHoLL0mO+CAWCR6eknlrB5Yp5izPKr
 WKxT2ijDfEKgiwVCWJhD/dfq3iP+BNy9lk6/r17SuYX/TOgL1ux3+fvWO2gcTIEa5M/gMaI6OwG
 X94tM0/jtXMODQqwlmG36ohEBBDxIw9Y8lSzyHNELF4GndTBuuc6GSMtjBS7Csz+sE2DO2T42wx
 OVaqh/LNfkAywcuAvDm2GqdUPjvaGv3JvXvJ8jHZ+zvC4/aknuARzIm0KvxA9UOmEHlzYNRsaOA
 WAtMXjztO7zuKQHCYur1pA0KWIxy5KP6fa6/KNRtHqxn0HMN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX4IptbriDUHKR
 r7sa4APJBdPlPNLGwwhMYsQC9hL4vOdp5JIhE0eBGP2UqPdkbCVPBj1xJb5LL8kLbldJ78DF6yT
 /PkOF4Ew5MdsBAlCJM7dxlIsMKZO6XU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX1T189bQUNvJn
 THxvqXWNWCVM+qDbeJ4EqxbJLIsWwNlA0BlfC1YeMA9p0xRjI6YxP5oufFmjjO0uTUPPdtEn7n3
 +UbSfKNJJ7dLlF4Nrt9PaAkvAkyS9SKxZVdJ90lB9kPnbNBDEr5x5u+tyQoYta2tSbGPCbJeses
 UT14TWR3/2okD6JiDSTMqZGQlnh2Xk1ZcMWas0iW2PlQxpIVCt6jzUg5BJKWqlJ3IvkNeRYMW55
 Sdk88m/idscZ2ePeZ8+6HGfRlFTd7giKUoV9nY3W5wEdETeB4yN9j1aGLxhxKP6EDtdFXWHhKkp
 vxrUqOEZj2CpdeQwvyTkCX+D0InP0EmC+fcXTMc9J5BwWGdRlydoqAzKdw2A2ACJB1yKIlsFZ49
 ftdSsTvfySwlEdyhjrfZpobQYXudd2pSifHoNUFWGNVTG9Fh8+0r23xZmgA+ZQPdW1oP3i3qoOT
 E5NpCMUbvsG/6gJpdPA==
X-Proofpoint-ORIG-GUID: q-66cQZxRCM6H7TwtuGwzBut0Zlkp24Q
X-Proofpoint-GUID: q-66cQZxRCM6H7TwtuGwzBut0Zlkp24Q
X-Authority-Analysis: v=2.4 cv=CP6/zhrD c=1 sm=1 tr=0 ts=6ad62ba7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=jFepld1HPJdq18AQ2i4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190058

The SAW voltage change runs on CPU 0 from an IPI, but it reaches the SAW
registers through the syscon regmap, which is protected by a spinlock_t.
That is a sleeping lock on PREEMPT_RT, and lockdep complains as soon as
VDD_APCC actually changes voltage:

  BUG: Invalid wait context
  ...
  regmap_lock_spinlock+0x18/0x30
  regmap_read+0x3c/0x78
  spmi_saw_set_vdd+0x50/0x1ac
  __flush_smp_call_function_queue+0x1ac/0x334

Map the SAW with a regmap of our own that uses a raw spinlock, and fail
the probe when that cannot be done instead of carrying an error pointer
around as the SAW regmap.

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/regulator/Kconfig               |  1 +
 drivers/regulator/qcom_spmi-regulator.c | 35 +++++++++++++++++++++++++--------
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index be6b72daa76f..83a76b78e58c 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -1210,6 +1210,7 @@ config REGULATOR_QCOM_SMD_RPM
 config REGULATOR_QCOM_SPMI
 	tristate "Qualcomm SPMI regulator driver"
 	depends on SPMI || COMPILE_TEST
+	select REGMAP_MMIO
 	help
 	  If you say yes to this option, support will be included for the
 	  regulators found in Qualcomm SPMI PMICs.
diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index c1a41ce70b36..a04ddb1eac94 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -12,13 +12,13 @@
 #include <linux/bitops.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/ktime.h>
 #include <linux/regulator/driver.h>
 #include <linux/regmap.h>
 #include <linux/list.h>
-#include <linux/mfd/syscon.h>
 #include <linux/io.h>
 
 /* Pin control enable input pins. */
@@ -1335,6 +1335,14 @@ static irqreturn_t spmi_regulator_vs_ocp_isr(int irq, void *data)
 
 static struct regmap *saw_regmap;
 
+static const struct regmap_config saw_regmap_config = {
+	.name = "saw",
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.use_raw_spinlock = true,
+};
+
 static void spmi_saw_set_vdd(void *data)
 {
 	u32 vctl, data3, avs_ctl, pmic_sts;
@@ -2504,7 +2512,8 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	const char *name;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = pdev->dev.of_node;
-	struct device_node *syscon, *reg_node;
+	struct device_node *saw, *reg_node;
+	void __iomem *saw_base;
 	struct property *reg_prop;
 	int ret, lenp;
 	struct list_head *vreg_list;
@@ -2523,12 +2532,22 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 	if (!reg)
 		return -ENODEV;
 
-	syscon = of_parse_phandle(node, "qcom,saw-reg", 0);
-	if (syscon) {
-		saw_regmap = syscon_node_to_regmap(syscon);
-		of_node_put(syscon);
-		if (IS_ERR(saw_regmap))
-			dev_err(dev, "ERROR reading SAW regmap\n");
+	saw = of_parse_phandle(node, "qcom,saw-reg", 0);
+	if (saw) {
+		saw_base = devm_of_iomap(dev, saw, 0, NULL);
+		of_node_put(saw);
+		if (IS_ERR(saw_base))
+			return dev_err_probe(dev, PTR_ERR(saw_base),
+					     "failed to map the SAW\n");
+
+		saw_regmap = devm_regmap_init_mmio(dev, saw_base,
+						   &saw_regmap_config);
+		if (IS_ERR(saw_regmap)) {
+			ret = PTR_ERR(saw_regmap);
+			saw_regmap = NULL;
+			return dev_err_probe(dev, ret,
+					     "failed to set the SAW regmap up\n");
+		}
 	}
 
 	for (; reg->name; reg++) {

-- 
2.47.3

