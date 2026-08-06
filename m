Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F233BCD16
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Aug 2026 07:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999859; cv=none; b=L1Orw4vI8nAWhXuOqkQja4d6f6w5rLv0buY6GVqs8hlVDFMFoZeZO0+r11ySr3tHmE3CfXcqVBm5hTttHS34E3IUEi1ex7TZXChe4/fCg7nTKe8tFt45N3QlCOs85bODoPrQmBi+vn6HLt+0A7rcAAv6O13UqrEXs6AMZ01UYUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999859; c=relaxed/simple;
	bh=BYfAIee57T5io1Zqj9+0qDuXvAu6FrFFjj5tJYNodcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JejEcvTNcO1358beRLvj6/LsWoU7CLhkbjr7YjqtyeEN9VVuPTcLWbwyavYuVXty+ZLEHdm0hFNVbJbUHS/LyureKYHnGELPUYq/hgZkCCgf/M6CX+OlhxfRg3pTf+B9+GQNokJPKYbxVhNjKPEE1JeMugePXaGm3yDzjeAketk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CGynNq4s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=grt/spUN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CGynNq4s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="grt/spUN"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6763wxdo482458
	for <linux-rt-devel@lists.linux.dev>; Thu, 6 Aug 2026 07:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	22uyTP7LDLXXvvcRrMs/fMN3tX7bdiG9lSsWhVhAkaQ=; b=CGynNq4sSoOdSsqf
	8sRIcqLk0mE2uodikEdnh5UxeS9VPcC5FrMAcCJj6QJnpcsjyVA1tYy+yvURV7JP
	q3F3+lHPQ40nICqkypQFaS0LxaKQtxy+Lc10II+pgnLF5jwFEEMwi1gF47Na6ICZ
	np/z8dY3xTwtVuSlM9uZpdVYLI4ZpInXN3tyxsh8z30nSxnsVHhQsYQaqu88pX+T
	oZ57NfjVUQ4xNJI60SkbLX5BALQUGu0CTX8wVsbutoViIzfaVdlonymJGp6vVnKO
	nlFcMEl82SHJTEo+WOdEsaSYV7BOUOEUHaJVCErG4q9qFLT+heB/nw2h8vfW62OD
	89sEmA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuegnfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 06 Aug 2026 07:04:17 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so2563350a91.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 06 Aug 2026 00:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785999857; x=1786604657; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=22uyTP7LDLXXvvcRrMs/fMN3tX7bdiG9lSsWhVhAkaQ=;
        b=grt/spUNyUuD+O8LD5cSTQSoAZ1PO8sa+grpgFbMwifPQyVJEgIEyjspp5+h0Cq/mI
         BBVocjRwY9ntmkueDTtxL4VsoMx9/W0BZUok55P3u4QVc65/S2VhIJHHMvQtjtI0s01U
         qGE0Hxx5BJNOYv4/+86BvSehmya3SPC+898fF0XEAVIRnZUtpZZQBMaKCGHpH/9xs7Iz
         aavD8y5+7bsddIpfvHvZNeSZR1FoOCBBGqZD4EX/N4gjscdCya2jsOTCHaSP6g522c9W
         c+SOVBFvTot5QsTVDuv5qV0PE4nHDoWN3xsyhS84wixG529q8tAQYnDlnOsTaTNGakcW
         5vsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999857; x=1786604657;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=22uyTP7LDLXXvvcRrMs/fMN3tX7bdiG9lSsWhVhAkaQ=;
        b=icDlfwGLpEN5w+u9fE4jFk5VXSv97fb9taf7Ec3+C7Ogz9WPY7JAPx5qSXLtg0HVN0
         rpBwfmpMD+N2+FAlXqNXz0PJgxrGVd5x7jYyZZQ8A9fYCeT1ASAu/8ddspMZIBvaSXUH
         kKcZbRiGmghTlNICDeGU4kp/gpi+HdqM8X9EHVyJhhTBESMYpQ+sIBhQfhQGiROKXN2G
         tH+FJtb8ObaTLMiyGXAivP9pn0GyDb8/I1uldpbdQY2p4vRPRevk6EUTdR3NoiiPPFx2
         vhlL7qm+u61O+/rGWeRjAS9xLnVS3OL8aisS5rKUQiwSG+/hyJXbTRAwmrdLE4G6HHDu
         W27w==
X-Forwarded-Encrypted: i=1; AHgh+RpE6T7gDA8/tSRSupfyqnntn9ALVi92Z0sS4U8f/SkOhORZEXN6d6ztNkD6Q5oCDuiLVYwCjqQXSblj04Ab/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwtV+x6NeeMwXvHmmyOBLwjQjK2L/vb3nwqmC1hLCVsN0ybEhpV
	2oFLAiUluEfcF3jMDUWAcaW2aomwLA4WHIODuq0olb5nVtVsU4Weyj7TDxoJ/u+w0mmxDW1ek2r
	HJ0m3WSVGPQe9ZbkZrmusvlHs30fOc5LYYP0+L4d+janOeqYslJk+KgaRVky7tJkqyvSPfw==
X-Gm-Gg: AR+sD12dvp4yUDNe/wWRfgzUulT+vxWR0MWgKS1KTioQFAHr180JLhr5OzajF+Jv5gJ
	tyRxtqUKoFbOiaVZZySGdacaz0jItFgep5j1B8mqraFCRdYtYv13DeCoqQovJbvmMfvajDTEkFt
	VpDbi4NFo40jjxMNfm/Rp3R4UWw1WOQk8kC0vjgM+o1qQ16dsQJE7JmoIYMyHbJDZVAjl0aZ8U4
	nxmlqP+eqT5+PKxIGP95ScOJlEARFVtVXiDEy8kKK/AAwUdiGasc9RXD2/bkUogQN+myDUNPYhT
	l0mfYUPidxQIpgyN9wDCoPckqXEMzQlLOB0AY1tPcdQ3HErWQ4Q/OLHjoPn+7fR0haKJNRRl4TW
	jBEG55KZEhlAlyKhPV8SFqQ==
X-Received: by 2002:a17:90b:540e:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-3903c681346mr14815944a91.21.1785999856857;
        Thu, 06 Aug 2026 00:04:16 -0700 (PDT)
X-Received: by 2002:a17:90b:540e:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-3903c681346mr14815859a91.21.1785999856377;
        Thu, 06 Aug 2026 00:04:16 -0700 (PDT)
Received: from cse-cd02-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085e4a2a5sm933308a91.14.2026.08.06.00.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:04:16 -0700 (PDT)
From: Jia Yang <jia.yang@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 15:03:56 +0800
Subject: [PATCH 1/2] mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in
 IRQ handler
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-1-d302a63dfb5e@oss.qualcomm.com>
References: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-0-d302a63dfb5e@oss.qualcomm.com>
In-Reply-To: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-0-d302a63dfb5e@oss.qualcomm.com>
To: Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>, jie.gan@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, Jia Yang <jia.yang@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a7431f1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=-bbF8U2482To3R46JpAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: s1E9sTDfX3l6F0BG3CJKJ4qxBrkfAUNa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfXxqp2SSXRA/ME
 +8YaoCecONlEip4IWI0bJ6hldMnkOT5+GCOJI2zZpXDqVdmuzSTZRQT6Eub6pyLRHMg95PI4D63
 bSIM0G0wB8uh9vkUwVu5a0kkDi+kq5BaAm0FOQhPYdG0v2lv9htltfHdT0cIPs9Zm0wlq8RKShL
 V95f6d7lPpbACTEp+2/Er4071eSIFzfU5qd0mBZZuFr/XrbqtoU3X96hdsbNCcsR9VVob9EO8EP
 A5TmWOogxSPp/F1zkq2hVu7wFjBvQpKtpQuhfQmMp98kmwX/BUw+tvDUY56K947aSgptxVkWFH+
 TFtdEW/wIk49K1PuNILM11Y5gqaSMXWvie75TQLAkvehFnHQ2nCMgJgZ7FvUClN+GT5L3FTwRWQ
 rUCjakc0CmGFvX29OjApeDdlolLDObdQzDpCDghfNLCAcPh+NTnc1GSKcv7KhYfvXOrYWUf+nVa
 87G3Ash1nVo+EkvK6yw==
X-Proofpoint-ORIG-GUID: s1E9sTDfX3l6F0BG3CJKJ4qxBrkfAUNa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX1AdLyJEgm+bp
 L5vQ7ZieOk0cf9CKI+fbpzCzbYaIdD0sperx0qtZfwC6jjC/wnIj//nyy0doix8wlAaaJxK408q
 i7TgNh4v1KzqySl5mIiCBsRuI0RlS5g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060052

qcom_cpucp_mbox_irq_fn() calls mbox_chan_received_data() while holding
chan->lock. Under PREEMPT_RT, spin_lock_irqsave() is converted to an
rt_spinlock (rtmutex-based), which tracks ownership and can sleep.

The callback chain triggered by mbox_chan_received_data() eventually
reaches mailbox_clear_channel() -> mbox_send_message() -> add_to_rbuf(),
which attempts to re-acquire the same chan->lock. Since rtmutex detects
the re-entrant lock attempt by the same owner, the thread blocks waiting
for a lock it already holds, causing a permanent deadlock.

This deadlock manifests as 'irq/N-apss_cpucp_mbox' stuck in D state
with the following call trace:
  rt_spin_lock -> mbox_send_message -> mailbox_clear_channel ->
  scmi_rx_callback -> mbox_chan_received_data [<- held chan->lock here]

Fix by saving chan->cl locally and clearing the HW interrupt register
inside the lock, then invoking mbox_chan_received_data() after releasing
the lock. This preserves the mutual exclusion for chan->cl access while
avoiding the lock re-entrancy that causes the PREEMPT_RT deadlock.

Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
Signed-off-by: Jia Yang <jia.yang@oss.qualcomm.com>
---
 drivers/mailbox/qcom-cpucp-mbox.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
index 862e45e8fbd5..0f7fe189e8b1 100644
--- a/drivers/mailbox/qcom-cpucp-mbox.c
+++ b/drivers/mailbox/qcom-cpucp-mbox.c
@@ -63,14 +63,25 @@ static irqreturn_t qcom_cpucp_mbox_irq_fn(int irq, void *data)
 	for_each_set_bit(i, (unsigned long *)&status, cpucp->mbox.num_chans) {
 		u32 val = readl(cpucp->rx_base + APSS_CPUCP_RX_MBOX_CMD(i) + APSS_CPUCP_MBOX_CMD_OFF);
 		struct mbox_chan *chan = &cpucp->chans[i];
+		struct mbox_client *cl;
 		unsigned long flags;
 
-		/* Provide mutual exclusion with changes to chan->cl */
+		/*
+		 * Provide mutual exclusion with changes to chan->cl.
+		 * Save cl locally and clear the HW interrupt inside the lock,
+		 * then invoke mbox_chan_received_data() outside the lock to
+		 * avoid a PREEMPT_RT self-deadlock: mbox_chan_received_data()
+		 * can call back into mbox_send_message() via scmi_rx_callback()
+		 * -> mailbox_clear_channel(), which re-acquires chan->lock
+		 * (converted to an rt_spinlock under PREEMPT_RT).
+		 */
 		spin_lock_irqsave(&chan->lock, flags);
-		if (chan->cl)
-			mbox_chan_received_data(chan, &val);
+		cl = chan->cl;
 		writeq(BIT(i), cpucp->rx_base + APSS_CPUCP_RX_MBOX_CLEAR);
 		spin_unlock_irqrestore(&chan->lock, flags);
+
+		if (cl)
+			mbox_chan_received_data(chan, &val);
 	}
 
 	return IRQ_HANDLED;

-- 
2.43.0

