Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29943D34A2
	for <linux-rt-devel@lists.linux.dev>; Thu,  6 Aug 2026 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999864; cv=none; b=D3TRcnwxdHwkKuBzlhCEBSy5JTWVc8zeA6/DXE927WeiMbMMIby3bVA7m97PFfAXNK4xvpATUB3PWgZo64MU3d+OZg75mzu0KUVhpGlWGlQESdJMnaXO+r6MBNoSUjKBpT23OaQa+uIFrEhi9qEfiLkb7SuLa8GF3GvrD87GjPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999864; c=relaxed/simple;
	bh=xW9It4cRWgfNV8sZOQXYl4J18dlzbDHWlo1gBwfL6fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j18XWc6z8yJkCJkUFWDPTIhhXihX0s5NGm8S66kQfBsshudmH6YMoQFD6FhdVyOHgbQZVqc8J4tLV6QRktg0IVmZwc2e1S0J0pYj/XDdZPrMGR60p6gIJKP0FwKg7kSZY/Qeh4lgyG5kJa9ZN6Sc5ZaqxFV334RXr/rAnVeZrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pafqk0Fw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ECfw4KbO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pafqk0Fw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ECfw4KbO"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6763x1rG482620
	for <linux-rt-devel@lists.linux.dev>; Thu, 6 Aug 2026 07:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zSC+Ja3GxB7onjnyHeXrVZErYQzuPWmeEzJrZZL3Fpo=; b=Pafqk0FwpoxLlG3P
	zoCjxBDke1jku4qS1y6spvwDddX67p6pLn+62/1jISeRrR7Kj6VJCcEpF6vH43vf
	xoMq6nx9fgid4qojH0a4h+4zW8//Bt/tWTls0NY66hX8ybj4nVxBpAIyVQbJV0Iy
	B6xVYbPDhynLmdwluhcUrB1cu1W2S7gbZYbdZXF+Rr0pp+noS4wkyjOcLoHs6762
	T6rbVL/bB0V4C13zoN0+D2eY2lN+eTC8j2vRntDQ2mTUiy/CjiZ3O9iRzLPTnhLP
	SnvYRRRvFQdMsE9ryl7qQVIqHCQ/oWbjbyToR9CsG0gjJP2h203GnFlSuhor0F6U
	2gju/A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvjuegnfs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Thu, 06 Aug 2026 07:04:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e475f83a2so3028644a91.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 06 Aug 2026 00:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785999861; x=1786604661; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSC+Ja3GxB7onjnyHeXrVZErYQzuPWmeEzJrZZL3Fpo=;
        b=ECfw4KbOYEfXQfx+aqDksf287S+EvSxnDz2h3TWs//1o3kT1DYuktth9fusHzgFp2Q
         zpyy1i+yLn6bYWZHVgPv8rSbMZLIYquToFWWIw73dei0vu6V5DDIV3dXv4fklTXAwDSa
         KKxnvME+nd0IWzv+YuNF0WyD++Xq15ksgfsEj2pR3w/DcUp+rGaJfuy8JP0bOwGYWL72
         gAVeLY9TuNs12sBck6ZzVPpBJta3vALVB9czEEVofKgKc+iOMDNZMn70Mn1EcPNTMnRJ
         3tlUmtyofqeFNRU/O5V4TsINcCbfVAFRfgra3KI29aFRgaPaBXYgwMWJnc9JnXGTP8u9
         2DvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999861; x=1786604661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zSC+Ja3GxB7onjnyHeXrVZErYQzuPWmeEzJrZZL3Fpo=;
        b=EEavyBnOZQqbpTi58iJgkX11gLE1BZT6cT4XOnmGZXChTwAbuva5WxYTPBXZ28oeZn
         1w/VqQNutNJKfu77ZJu2zLQTMgYQ8PAepDv9BcLkqjO4+0XWOYnnH3lI/+JC0A6d1hCe
         qzPZMxgKeF36zQi1xZdJoIgXfR0z6RPzBP7DhbkqV/DifywidJvNXjhZrMbzeKrn0cI9
         fNAJ8ie9JpHFMafVnzLzSyXJTQRW19D3Kb5A5ZUDT9sqReh9PF/fGP53BYfWXlDmTJn6
         ZmZFLOmvE7BefcoE9N2HwiWx4Kmvvgb2/AjinpsCII3rvDGNqaa0vAWs9LmiG1oHCNER
         NUww==
X-Forwarded-Encrypted: i=1; AHgh+RrleRF9xXzIP06zzP2/0yt+c9vobgLM3ysaxKYMUi6AqsI9FtlrHtEYo7pgaWwQIYFxrU+9u4jqE37+5odVsw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzspBlUtaIS6LAWOGY+55vorIIaTLFiFSZOcbJIcGOSskXZel6P
	5TN4REHbRg2rLfvrJk5Kqqc4pIhNv/ZbC8XEBZ2A/4Unx4YCNo/Xr5GTjviyAZBAlZ6NidhsXhF
	3GFr717ncsS8laZCPEbJO957PsdfR9TRI9JKnNt1fDfGbSHkQwnmGF3V7k8si8H6IC0xECQ==
X-Gm-Gg: AR+sD11etnLGmfTXJapWTVMiDDlrt+qYL6XLIR5747C7rxEHZg8EJuwNMAJZGTz40tN
	cqBKehUxoFZk4wx+qpbChn4Cm4mue8WuJxgtuI5Om2UFNsN4H9QbeMZMy9tC3N93Zz/f31r7A8c
	3WJjTtxBm5H5uyoRhPNBMO24Jb/WUglxmdmcAEnvc4lu8OrrM+dcHYqO9oxERIUnw/B0qLMZpRd
	QSVIwtFc68T8vqJTw85APd6I7aJIbJmyJgIQFIjycqlVs/AbEAsA4IGlibUBCpB8XYFQk0Z+D7w
	0Td+ZMTS7PeeEBOVf/bxB0edIzzl/dSDKLB6i6qChmORk7q5tNcpPoRW0TA/w9nwPf/s/EUSfOC
	yszofHwAK4TGoXQkrf4OC2A==
X-Received: by 2002:a17:90b:1809:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3903c583c08mr11593183a91.9.1785999861476;
        Thu, 06 Aug 2026 00:04:21 -0700 (PDT)
X-Received: by 2002:a17:90b:1809:b0:37f:e177:f58 with SMTP id 98e67ed59e1d1-3903c583c08mr11593141a91.9.1785999861120;
        Thu, 06 Aug 2026 00:04:21 -0700 (PDT)
Received: from cse-cd02-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085e4a2a5sm933308a91.14.2026.08.06.00.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:04:20 -0700 (PDT)
From: Jia Yang <jia.yang@oss.qualcomm.com>
Date: Thu, 06 Aug 2026 15:03:57 +0800
Subject: [PATCH 2/2] mailbox: qcom-cpucp: handle NULL data in send_data
 callback
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-mailbox-qcom-cpucp-preempt-rt-fix-v1-2-d302a63dfb5e@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aNzAb79m c=1 sm=1 tr=0 ts=6a7431f6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=Et7Q1aUyyLuhVTyguf0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: RcWcs9rjQt-2ZDeOo3TiKJE1U1zSmuGd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX0rC7LlR2Gyra
 UsrMgGUt1y5kK0v82AWsmH7zKjJuMfSlrKnGbfiz0Wc82qk68KO4TPsObCgCJNgDW7HWK0mLPMr
 SbnsIFHagCl4+MfuOVtwbZwudgs8B/h0bLbrKoJIAhC8mlrtRwP31OMJPJVmnMH8q//P0DmJc/6
 RDe2r4FL4xUAbVoQXw3ivenWi8qWJ91tVaghSSyRyQw5HV7w723Do51IWV3W2/RCT9RL2DMIrvb
 cm3vEuNGQ6r9ffsPBI32un8yo3mcnH7h9Oeqyl2QA37q2r79FDJDn+s4ydgz6rBFn0vf1DqUr0z
 3Vx+pmG2glHT/dXmcclcSCilB9dFlvtfwPi4QA/j+bAVeyinkgKiQCrwQlO9ARVHB6Nmy9L7I2E
 au7PLBipEXlhvuiyFFHH65fbRtSgMnoUp3tvdr9pFZxanwRK11o8GTa8Gf0t1h3cHs0/y/X20zW
 awZw893J+L1B5ebLd1g==
X-Proofpoint-ORIG-GUID: RcWcs9rjQt-2ZDeOo3TiKJE1U1zSmuGd
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA1MiBTYWx0ZWRfX/1gAKp//Acqu
 YIeGsbdRNTKrgiLz8fZ+c8U9csCA0j1UZeXfRdE4VDyO/FFxkWYIgF92hoSXghmK4PL85a3S7tZ
 pD01DebDtaTirzcg4eDYMcVknMbAcdw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060052

mailbox_clear_channel() calls mbox_send_message() with NULL data to
notify the remote side that the RX channel has been cleared.
qcom_cpucp_mbox_send_data() blindly dereferenced the data pointer,
causing a NULL pointer dereference kernel panic when invoked from
this path under PREEMPT_RT.

Add an explicit NULL check and return early without writing to the
TX register, which is the correct behaviour for a channel-clear
notification.

Fixes: 0e2a9a03106c ("mailbox: Add support for QTI CPUCP mailbox controller")
Signed-off-by: Jia Yang <jia.yang@oss.qualcomm.com>
---
 drivers/mailbox/qcom-cpucp-mbox.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mailbox/qcom-cpucp-mbox.c b/drivers/mailbox/qcom-cpucp-mbox.c
index 0f7fe189e8b1..298b357c0f9a 100644
--- a/drivers/mailbox/qcom-cpucp-mbox.c
+++ b/drivers/mailbox/qcom-cpucp-mbox.c
@@ -117,6 +117,14 @@ static int qcom_cpucp_mbox_send_data(struct mbox_chan *chan, void *data)
 	unsigned long chan_id = channel_number(chan);
 	u32 *val = data;
 
+	/*
+	 * mailbox_clear_channel() calls mbox_send_message() with NULL data to
+	 * signal the remote side that the channel has been cleared.  Nothing
+	 * needs to be written to the TX register in that case, so just return.
+	 */
+	if (!val)
+		return 0;
+
 	writel(*val, cpucp->tx_base + APSS_CPUCP_TX_MBOX_CMD(chan_id) + APSS_CPUCP_MBOX_CMD_OFF);
 
 	return 0;

-- 
2.43.0

