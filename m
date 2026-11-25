Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795593982;
	b=cCKAd2hZpldsj5iZBsoVFxd/mIhAM9cE52fOmD/a1AZW+e+tdR2/vjtaDAHDapVH4DBf
	 HGW22F8gUfgZHVO/5h8xMGXyCeYukydIW3Nbt3ek3Rd7lpJFoTABHCpsex2PkripTTn5O
	 ImleiEpjUw4y4h/xpSjg0cq0bjOHUs7ykKO5LEkf0IrpEAm4OwA9SFvKIK/DTe+sR94SF
	 ttI8attnYaUh9hkkmJ9NU9dWfPa8lOPOOM3ep28SD+eawDYoBBMD7kUiodENWdzHUdALg
	 ZRSbtH+SScY1p+tZndcspjaVCvu8cTtWVUvShC9rX+s7vtDBX8j/jIqzrxVB6vIeemQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795593982;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3P1yGnLgU=;
	b=te3Iwr1OfhvXHywUSxtUPkxJxmWLJShrKHPhQdMu6eNli2dyWo5KwTBy/+j5GyEibt3G
	 AQGV3mVGWLTwuRIGTCBPd4KxLLRw7J/S9zHRSqjhrL8+SuOQGK3DdElqOFAQXEW1JglCp
	 mQ53V2KphPq7kcg8JmUZ3gs0xEIPL2YFHiozNcS7ZOTe7AR4CcqrC5RUePA1LOmtxkLl/
	 3xlgEqBWuTmUVQ/QDU4QDr+cXWkiyJgNbyP304Kpxg78V1kI72ikUV+9OuQhQKov/CKyf
	 p5ODZjKj9AUMxjPfFfWF3UvlDwkcqH0FQiAdAWpBzG6Hu5SeH8k55pwn3azBxpi1P3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dOgmEFAK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eARhwQd8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B923606A323
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 08:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B923606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dOgmEFAK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=eARhwQd8
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP68ZO53142811
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 08:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3
	P1yGnLgU=; b=dOgmEFAKM1/IgLulpGR1NimjAHrnA2tEsxS4CwsLaQ81ccjWW1E
	qD1+mriH+I4U7dJXU5rXYtFGnzkQcQM8xJyl/OKnHsXNJ2oBpJz79gCdqwRbz62W
	eFb1vsXzJZXuN6Udxn2stARmD6huOEj7rDIKV3jM9bjCnASHVPT33FEoE0L/ZOJp
	KA7iRQQt2WXbgEm+Kpn5CQEgZMQvEuklSUwUfhudCKaiNDLeHSFGL7UwTWnaCz01
	+6IkAvPmCpRIfpPuv1qlDD79qir1B273eBrvG3Q9X4xzDclasq3teZvl3rP9plbr
	CaGH1p5phj0HsTIwQLyT1KoWNpv/51btbSw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc29n6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 08:06:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a08903566dso4444206b3a.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 00:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795593980; x=1796198780; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3P1yGnLgU=;
        b=eARhwQd8Alfw8SU2mFw0tJoBnJupnB/eVTJW4Fdc7uo27a1e47weoBt2qxQ4BdmeTj
         itwmCAbFx93Ku+ri8sRAVnnF8sUau31q7fecwZUKYHViG0Nwg3C16PRadLYVrzCWP3WV
         7HAXpK35gk0GNBnDfHVhuvIUE8+DZTfMhKFUbsqv5SgAFK6n2z2BGF9m8pKKYHwKsDyy
         65OoBLkXa1Bq9ctc84MKA3fnA491GslN/ypjVg/jiL/G+kyMuQwqh7I3juTpMre3hS/g
         fZUdbheVvnUHW4kN4x8Ca2Dlt8aX4StdV8YEhGm1FVQ5f0cu3W50bGI8svdRtCXoeJEr
         w6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795593980; x=1796198780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sKV2vPrXRT3DyV7gNQ89Lv3MmHhwVuLo1d3P1yGnLgU=;
        b=LAobDLaayWSlmBxxAp0bT9GtCdL3aF2gzEFWP19/T+f/U7hyyJ8vBRX90w9EodrpTW
         Kf9aBC4KAEm+GoLcz/DeIESKQOFtPjeE6y6K8Z+TB48Mn7m9ZN+KlpMzFk7iRBMql/nA
         AwwEWPx/2fL19ZPNcZ1apa5PekO/D5BNACIoGqcW8+chfOpUtG8QMpmhsAZhzj/0Srq3
         uF9qjnWHQLsTNWI26HCop+ZTWpqIZ0wk5dlyh4TmsVCEe8rzLsZa25CEChjwTS578c7v
         v5J1QyOvuLSZbZwOxQ1pBzI8wdyxWGnOecaUoXwTiwbdBYTBzbucGn23Bpx2PB+cdzOx
         RZGw==
X-Forwarded-Encrypted: i=1; AL+hErEZMQs2bId9nhqASZXqWlGwmtehOFuqeHM4OXjZDxTNXQshqF+HKoM6D4P3x46f2COqvVf+h1IN3NCeUbxz2w==@lists.linux.dev
X-Gm-Message-State: APuU4Z9ObmZbIMVRHtg1JleAJE82gYs4OlyyAajeSfchGZMGIC6gQARW
	G6SheG5XAKZKZJ7QXplDYes3IKU+XWO+HKr+rnXcoiijiimYHdy4mfzVfQos0eRZlUI1WOXPZkc
	jO1yuTf414te55Di+uHfYLkslI8XbyqLLnNMnIbuHHboJIXwdC7UkRKO5SBgqT7aurxsbWA==
X-Gm-Gg: AZFdTZeTxuiqYC5BjBI/mDj70lweKdUyaewpAsik4Z2xJq2y+2yw7ikQrrgZdHEduj1
	FTw1fvSPalk/O4io0a6BnffcZNMVt9ki3AVMbJ7uD+7Mloxqd+2ck2yL33hHH55nK/HxsLodREl
	Gtx64ElK9nrHUmzUxL2pRsNPGqUS4NZcO1YjKPpQn0/UVtLpVMpkXL2LXGqymww6xp3kONRoPhE
	sEFSSX4jdiPnHDMqzTvJ/oeLwKkGUy6gtWNLSQQx5VUsotNHdmWtwaHqeKWxmXkmG1Qwac/dzKA
	MnjdhNXq50EppNZGEU8Ok1fsIAoocRsavaesoOlQ7+HomtKv/mapxA9+8KsoEg7eQxtetVy5kzq
	lgrD1U5R5Zz/eqhysG1OS2P1eFTLj8xleFZh3dxUjv3no9JGiVozm5O0wpXnK36tktq0rt/Blfq
	IUAzIGPaCsNwJ67Z3zGGe53p8m3ys/fYRucERj9rU=
X-Received: by 2002:a05:6a00:21d6:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8c87bcb7b35mr10647266b3a.8.1795593980046;
        Wed, 25 Nov 2026 00:06:20 -0800 (PST)
X-Received: by 2002:a05:6a00:21d6:b0:89f:2b65:2a1 with SMTP id d2e1a72fcca58-8c87bcb7b35mr10647255b3a.8.1795593979558;
        Wed, 25 Nov 2026 00:06:19 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c873b25bfasm8558604b3a.46.2026.11.25.00.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:06:19 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, bigeasy@linutronix.de,
        clrkwllms@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH] cpufreq: schedutil: Run irq_work in hardirq context on PREEMPT_RT
Date: Wed, 25 Nov 2026 16:06:13 +0800
Message-ID: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b0696fd cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=m2RqmQonHRMwM0EXqw8A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: rvHk1_ZTSCbUl2vujNsZsZJaH9oMAcgV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAzMiBTYWx0ZWRfX1q1dOqxTjqUa
 iSdM81dDsmZ0sKH0KDXPT0wk5C1OGr3n778ZNIhl0z66sBNRhk9L3B1GW9WPqig8MZZijzESw5w
 g+f5AHViTpot43R8Pa8amb8UKolPW2hX/bnPlmnJQzBuYDw8U9Cu62DkWLUbH36SjpRduOHJKsr
 lDEHGZ7eLiuqKv6J4EtE97iUEsHO2/uSP9hNuFaRoA+v1NHmZxDviWdt/QAUSNKQzLUom1aQgAi
 r5Abj9CDoMyK3NcSRZ82axpQNB1DNtOS5ID1C56a41UojzAPpj1IytL0XFTjruyfUIUTcvoct5V
 S52fGr+dPeGMXRKzuCAtSKNPVqjf5Mqfeyoc4UZ7+ZhUKREaf4+ovXMBJbBcz2em52tQUZPwI3s
 Cg5vdomdBtCRSsmY5wqenA0pc87cZRHoKJNJr8H/YyAFGgYA1Go02HB7erViYidOQGG1BIpo2AW
 v3a5Su+nFwFnBupxZyg==
X-Proofpoint-ORIG-GUID: rvHk1_ZTSCbUl2vujNsZsZJaH9oMAcgV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAzMiBTYWx0ZWRfX5kZ84/Yn/FDi
 PriZM0fHDFAA78v2hDv/ZtLdjPnZuFpOdkJz8yTeHb8pcwbn7pjnEXkTkKSjW9gJFLWNUZtP1eh
 VDZ3GWZzX3EPixZm+lCzS4pCe1MLUMY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250032

On PREEMPT_RT, an irq_work not marked IRQ_WORK_HARD_IRQ runs in the
per-CPU irq_work/N thread at SCHED_FIFO priority 1. The schedutil slow
path queues its irq_work on the local CPU, so the wakeup of the
SCHED_DEADLINE sugov thread is delayed until no other RT or DL task is
runnable on that CPU.

Meanwhile work_in_progress stays set, so no new frequency update is
queued for any CPU of the policy: one busy RT task can freeze the
frequency of its whole policy.

sugov_irq_work() only calls kthread_queue_work(), which only takes raw
spinlocks and is safe in hard interrupt context on PREEMPT_RT, so mark
the irq_work IRQ_WORK_HARD_IRQ, as commit f8d958880933 ("srcu: Use
IRQ_WORK_INIT_HARD for srcu's irq_work") did for srcu.

Tested on a Qualcomm SM8850 board running PREEMPT_RT, with SCMI cpufreq
forced into the slow path. With a SCHED_FIFO 10 stress-ng worker on CPU1
(30% load, 50 ms slices, 15 runs of 5 s each), sugov_irq_work() now runs
within 15 us of irq_work_queue() instead of waiting for the RT burst to
end (up to 212 ms), and the policy frequency is no longer frozen. The
irq_work latency below is measured from irq_work_queue() to the entry of
sugov_irq_work(). The cost is that the kthread wakeup now runs in the
irq_work IPI handler, as it does on !PREEMPT_RT. In a separate cpufreq
stress test with cyclictest (SCHED_FIFO 90) on all CPUs, this raises the
average IRQ work IPI time from ~0.5 us to ~1.3 us, with no change in the
number of IPIs, and the cyclictest per-CPU worst case by ~2 us.

  PREEMPT_RT                           before              after
  ---------------------------------    -------------       ----------
  irq_work latency on CPU1, max        130 - 212 ms        <= 14.5 us
  policy0 frozen, total per 5 s run    0.57 - 1.25 s       none
  cyclictest max, CPU1-5               13 - 16 us          14 - 18 us

On !PREEMPT_RT, cyclictest and IRQ work IPI duration are unchanged. No
lockdep or DEBUG_ATOMIC_SLEEP splat on either PREEMPT_RT or !PREEMPT_RT.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 kernel/sched/cpufreq_schedutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 14405a614991..b2e9ac7e3517 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -726,7 +726,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 	else
 		kthread_bind_mask(thread, policy->related_cpus);
 
-	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
+	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
 	wake_up_process(thread);
-- 
2.43.0

