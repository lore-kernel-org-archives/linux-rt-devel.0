Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F226F3DC4D7
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Aug 2026 07:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999855; cv=none; b=Df8VNK7sS8nt9sGckledVE7rZMqFBe7HD0spacLcOE977TrwjiHMRsJudNNFFTrmj1pAiMR6g2EkMoF+HVSArYm3/rFS1u7abFsMG6ChTpzl7cSBl+egzKhpEICQslTtSD+i6d9FuirvtvWB8TYOZ1NG+EhUlw067JtgRut82OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999855; c=relaxed/simple;
	bh=H6QKx2Emjk/rlp1rta25v0hWa3YxPKK8h+kDsYQPWSs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jBnD8zEnk0WcGvwgnV7UqPcQZbBDz3pwbSuXmMq6Us5V6tGeASR8UIfZEBomnWTj7sv9P3ItoWVlDlb8oFE5h5HDr5+5PaKKXlpOIHpWR4AHR7rAjPh5uZsCRK6POPvhCqCZQQvIbQVX5Bl2tRsP2/mVpYwJQv+MvbB6qc0GrAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gVVNh00z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MmWg74mO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gVVNh00z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmWg74mO"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NbNUj3702143
	for <linux-rt-devel@lists.linux.dev>; Thu, 6 Aug 2026 07:04:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=xgLJn04TYXjSMKET2PzbgD
	RiW0Fch7C6B20lyKlrkio=; b=gVVNh00z/ccc7HCqehYqEhXiNoEbM12oGZABb0
	KPaaySgpr/Md10PS334N8655lSR9SDLxASiMjZqoU9ZzfiXVdYoNRGWq2QspIBK8
	dY6jpuAw8Ep/Vn3mpH8JehcGzuCkGR3FOG+G4C+nK7hr1xISH5bDD4vSNlsF7/2L
	ma86mKkouRXDSrmnzCw8FOdQdx5G/2cKmo01b7Id9xE2urJILsvuCHTj6TplhaG5
	+uFWBHMLT8+wmgoekbJH4G23WYIJHDeAlojdH/qfsZvC5DY/PU+aWRqN8SI1z1bS
	1F/wqodiercWtxNFWJXDuipV+1l32O8OxKpMabiTrnhXYGsg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv9f5atqn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 06 Aug 2026 07:04:13 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-385d2703b64so643485a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 06 Aug 2026 00:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785999852; x=1786604652; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xgLJn04TYXjSMKET2PzbgDRiW0Fch7C6B20lyKlrkio=;
        b=MmWg74mOEz9WY5Hp9gtPRzK3+jqQgCB5LLv/w1HeL19kOvGcGxkcQrD/gnSMua7Pqa
         p/1U9eRuHMGQR9yEhJjt1R/jhCwikvjIY8lwlNeBNtGmYWUwddkToaXdJv/xcAAwDEmG
         EetvRNG1mRVe8s4kFVcrwAJX3Wtuu3AcDyM4pcMGuSQuKckVpHgbYQzZo+NKcXOJS7GT
         r+4owDHYym0kngyMphpH5j6LOr+NRAx6g3nCXk/Vd+QhYT3islfM5LsCnQShNohZrWjO
         HqQaa0d471sSEg6O57SNIVl5eQR4HA7gtThsoXQrUyQkO5Nx+2haSTXDfDnvZ2wQZ2Rq
         cLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999852; x=1786604652;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xgLJn04TYXjSMKET2PzbgDRiW0Fch7C6B20lyKlrkio=;
        b=MdCdY8fK7X0iy9Qni/I3L027XAtobGYAjzipifHI36aFf72vBnjLOxiq3sg6LEyhNc
         VljrEwwDJ3ajICC8O2XRFzVpKwixGscuQ0mXpNDvkUOFeIarzWOmZu8FmIAe98MaOAol
         ZCSvjiSMslj090cNrlC+YyGVI/i3puOn+f47J8lqDlX3D9XRP3lo2xNFLnw4cGKzOfMB
         UPVDGZlzVeDLP8RL4ZGK/pIQG8OJTXF/25J8yjIaqb/7hH8bFzMvk8iSRiBS8Ug4raHd
         f+BhG522TWrHjG7w+0a0tcS2IlP4DfN2g9Y3b8Oa6PpcmSniYl6C6pvPTxCTpJC513dg
         reEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrSXQv9xRaEzOP8dANu9W9P2f9YGylQ952QEg1M/Nnia1Wr2nWUugLBEqV3mxrTlzpAaXDfUCOEKkjxAc8eqA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyGQgZfd/V95EgfZ/NgfcRZE7xvAfFISPDF6cyqhNaylAT7/PpN
	GUtIMgylq0/r9A2aXzaGFpte2uL/7AgcP7O4nauPzECCwYV4JSAFwQI064ylXdMCfrVEcDRIPEV
	2SF+y/SAlwRSMBro5JOe1ysAaXgbKPiZ8oTy5R5wGij7wWBt2zrp6iO6nTv3TepjPGZgFkA==
X-Gm-Gg: AR+sD12ECk+xdomcaRYY6o0bkK7Ush6bQdot9xJ0LSl4qWIyGl1ZjgEJTufgRb2g3yn
	bFIxsRbj3c8qzh6M7KtTxragFUUpRakNh9ERuLcQLk+lf+fZuEuUnCWPkqG1OnQy61zrxLhYJKz
	mSAEx7XpPUeDB27XM1mAqBEfN2CziM8WGp8k53yXjWUg80j+U3276IF1mRk3HepI/AFKZy3ID57
	WiUie3adnig/qcJKWtnXl+cSE14wE9SsIf49BYZI+v6lZ+Vz0N4f+AKV/NbxGWU5mBhz+RpWI2V
	9koldinUecaHYv/+Xd1ujX+8YxT0pTz6zQzhkw3pQGMWjE5nFML7uRwRtU3tIJwKR1M4F8MwgYV
	+DKQkQe8F1TT60OPxmwevHQ==
X-Received: by 2002:a17:90b:4d0a:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-3908972cd26mr1033402a91.2.1785999852373;
        Thu, 06 Aug 2026 00:04:12 -0700 (PDT)
X-Received: by 2002:a17:90b:4d0a:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-3908972cd26mr1033374a91.2.1785999851826;
        Thu, 06 Aug 2026 00:04:11 -0700 (PDT)
Received: from cse-cd02-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085e4a2a5sm933308a91.14.2026.08.06.00.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:04:11 -0700 (PDT)
From: Jia Yang <jia.yang@oss.qualcomm.com>
Subject: [PATCH 0/2] mailbox: qcom-cpucp: fix two PREEMPT_RT bugs in IRQ
 handler
Date: Thu, 06 Aug 2026 15:03:55 +0800
Message-Id: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-0-d302a63dfb5e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANwxdGoC/x2NQQqDMBBFryKzdiDGEMWrFBcxTtuBxqSJFkFy9
 w4u33/w3wWFMlOBqbkg048Lx02gaxvwb7e9CHkVBq20VaOyGBx/lnji18eAPh0+YcpEIe2Yd3z
 yib01g16Mdf0wgvyIlvluPOZa/8NQ3HtzAAAA
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
X-Proofpoint-GUID: 7tyhBsAy6T9pB-PShpKHAe-AdHaMhUPA
X-Proofpoint-ORIG-GUID: 7tyhBsAy6T9pB-PShpKHAe-AdHaMhUPA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX2IKiNslhu8NE
 7zdwq/c4Zs4ClG6oU4mO3G8RJOlJJy3DGQbnJh9O8XSSUaxhkH/kIIiZk41b+HGGeHwN8oMDKb6
 wa12gLhzFA6i7MUakAjPPU0wP7mEnfE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX/sm8Q8O87qvF
 aL2fBPftDRbDzkXQgWfK/HQaXQRu8s3sRTfvLpaehp0bVkpN8H4HBu+USFGsdr0oEEhbUctkRZ5
 QcICMjE9bGqINME94rhkqQWfx/UYVNlnYD+U5s4yMZyFYVzmkewuDIjgeJ4cBMSE320+8A69QNR
 /o21ii3o+okFP85T2wwC8190wCrH+F0kL56c8YxbjbTq2HqIt3Y8ErPBUyRI+ntrCD6sbhR4c2/
 uctAejW1CL0uEWZQMLzRAoxyZPI4jZX5qTXCe7/yxd00eE6Bw2EizM3YLJAxK8jzUWI4CXShaer
 yNRglbQxdH3+YPFrqBivv7lZCshQguaSU5H/N/sVrILiiTXGxpV2CrCWzj1LEHeqwbKBg0xupaq
 FwTbsX9eE2LXwg8KZlBkKdR6qTfpTuz/6PtWWz9nLz7xq8+ojV+9yyVwtGVtRH2r3G3Jhs5Z0uN
 A8TJf2Tw4whv/SAxG1w==
X-Authority-Analysis: v=2.4 cv=d4bFDxjE c=1 sm=1 tr=0 ts=6a7431ed cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=bedaI3WIm0SzTz6enF0A:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060052

This series fixes two bugs in the qcom-cpucp mailbox driver that cause
kernel instability under PREEMPT_RT.

The first patch fixes a self-deadlock: the IRQ handler calls
mbox_chan_received_data() while holding chan->lock. Under PREEMPT_RT,
spin_lock_irqsave() is converted to an rt_spinlock (rtmutex-based). The
callback chain triggered by mbox_chan_received_data() re-acquires the
same lock, causing a permanent deadlock. The fix moves the callback
invocation to after the lock is released.

The second patch fixes a NULL pointer dereference that was masked by
the first bug: mailbox_clear_channel() calls mbox_send_message() with
NULL data, and qcom_cpucp_mbox_send_data() dereferences it without a
NULL check.

Both bugs were reproduced on Kaanapali (SM8850) with CONFIG_PREEMPT_RT=y.

Signed-off-by: Jia Yang <jia.yang@oss.qualcomm.com>
---
Jia Yang (2):
      mailbox: qcom-cpucp: fix PREEMPT_RT self-deadlock in IRQ handler
      mailbox: qcom-cpucp: handle NULL data in send_data callback

 drivers/mailbox/qcom-cpucp-mbox.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)
---
base-commit: 3df25501ceec0d590d3ad416b571563beb364fb7
change-id: 20260806-mailbox-qcom-cpucp-preempt-rt-fix-36472b46a378

Best regards,
-- 
Jia Yang <jia.yang@oss.qualcomm.com>

