Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602902;
	b=G6G2cISh22iX0oAdCJaI0h1PnIEuXK1KqZ6v7BPLAAojKu7xR/ZjCna0HDacyOty7FL3
	 AlegKDszcwlK2IWVRjYEJsdgDtG4YJ8oS8ilGuog7EVSvDaw33/wA8Btxnef1L39RcRnO
	 rbG8i/nCk1qeAPlfrVpLuA1DHs/4zjdHe955M/IIXCS74oorFxjX0DmkkCCMgNCTBb9pZ
	 Zx40pQGzKXbqCshibAlhAZ8XNDW5C6VNQBTyw93kVjOwS5P0Sn/BXq2UOKoPyo+1O2+Hk
	 0ujUMVruoowayDL6dPPEY06sL9kkpKyRk3L9CoRMLj48k/sLINJLpiOZx9/UVFrQH4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602902;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKRDLf85eBc=;
	b=S3ERNUArEl89Lqlyd4asI/CEjOd0CMFIDybk3PgY3xJtW2uy1Z3CoB395jhZXS0u8xJq
	 zZkuxWBpMeLSPHtkHpASGpUvBn2aszEekQmwn0NWVVgYYkM67+A69X7g+p6SvLXZa8B6n
	 ooqHk42VAWC/je/WjJtJJ4BWpV2s/FyA2xFeAQK1QyNtp0Ujj1FyOas2lMuYGO2Pq0UJu
	 omqr5OTIgxS1UgCk17+tMb3ci2NIc7SsJo/8dcwiyNeI38kcYhaqcgrrmjj35QrQBu9Gi
	 w81TykrHsH5bZJitR8r8b12d6KbiQGAzjE22DrPi9U2Wc7Tse2JkgVUtAKswDb4PJIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WEJxPzW4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I3fovQOI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E30606A334
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 10:35:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99E30606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WEJxPzW4;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I3fovQOI
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9miCh3642180
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 10:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKR
	DLf85eBc=; b=WEJxPzW4QNtLm2FXJyMaQDhU8QRKMgn9q2nwODpdPKmp4xadd/Y
	IeG/KEximjTHnDIYrqcEFj9FVsy2uXcmrthC+DT1DZNnZKNjgSKdHmSJQhQlIn0h
	ABXOE20uMP7WO+C3fFsAx/p5m2nfmFCPp/GybprE0jhwgd4JHIS6EnS3TuOF2wxG
	fiB3ck6sB4vY4rOstVG4YDvGZzN6ah1uZInLBkjbHOVept0AtywwlprMG3w/QwF2
	K5gGGl7nb/LexzDvrKE8ewAvV5CQEF/9CU7ET8RQ1Wsa0+cQSMLFEYpQILxi4FhX
	9w1qMHEPnMXTKbzqCKuUpOCzTYvusOA+xFQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5mc2ad0q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 10:34:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cdacb64970bso3188974a12.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 02:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795602898; x=1796207698; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKRDLf85eBc=;
        b=I3fovQOI0nwfHdAIXN1MPnkJMCTfcyQmbFraAOz6p87m1IkcfoTVd/yxwowxci/IIJ
         Iu00Qk/7hS3XQNaoEFcaTk1eOojCt1lgkOwGqOPkpAmtaExFJYypeytRfzxe+3SCRhI3
         PkfjAxsAmuPZ9B1zlAJjrSJZqdUJXMYtv+ntdKwZxFOVFX9vBi+bBVlCNSka4htyzF2c
         X7uZDrcZ449WIAY1F3D7jCA69nacVEOX8434J/2Cp2rQyrKsc8EHII2BKjMF3eaN3Uv7
         bo9Y8JM16iWa5YWoPbSJjNM18b9AHqk0CfE91SHOfrh/Hs1nEktE6QCHeUYSh+FEKidw
         6hqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602898; x=1796207698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlOmfRoB6zB9jpYaxnGjQXgLmnAlfwFUUKRDLf85eBc=;
        b=1FV3cUegfgNVM4QcXvYVR9bl688CIILVy8Uv++TlVcGtb3yYPNSU3wABhS/diOazPA
         rpKnziemAPDwlEnYBhM8D8/4SulPvoYxyOJEbM3VjRgbo1eV3SbwRcWLOXD0ZsmfOzYB
         9OIMyOUQwBq5mDbTfbQaicHO50FEmfs0jxWHg0rfxrvobaix8uEQgDFPS3AwVldkxwtP
         zd8sVx3vOs6L0oq/2BM9YYZbTp7SvZDh2qefQW+vwhmJ3UWbbkLP4OiQKKYWmbdmYG2u
         1rTPrrxOfq/eKnPFeQD0ElrIt/TMuxpi48P2y0LMCnfIU+Ad6OXVuwXwixqSBPgZaHw8
         u7GA==
X-Forwarded-Encrypted: i=1; AL+hErHm7QEzenLU19ZqKyQCAtpBhmFnp2gQPTSZwrwY6GnYuhnnFf2UfWJ5rd+07Auta1phEmzl9LthQypmMHQCXQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z+pUkkwsm13NbM4Ab37riYQZUmtekzpdaeNNBJxrdjm1JGvcqKS
	1LbU+g63LyWyEefOmG7YIxAkArjB59G0OrE7r2jXxTNggRzd39uuM4WZcPsXbrxWTLZ7ULP1B7w
	24Ac9VzEEWrnSSeS6gWJnSEX0F+GBog2FjVAdjY9T/MAfN2ggVdJdtyqfVqOdzsXSnuGJJg==
X-Gm-Gg: AZFdTZdd/xYRaNc2ZdcccKzkQ6Ke3dlUy8WHTtyTnlCmrbgADKTtHCv/dT/v11xoZeD
	/DJgxE1qguQuC6lO2rp1HS3J3DOKL2lZDWcuCvY8igFq0HPzIDjB68LVzevWA7/keS3WgHN+fTy
	Wgcx5VJczuIfjA9LRwEY7bb8bBlq+MhWxJhlY+L7qnFR5ddP+041y6et4M5uViMXsokuqlXyK5i
	kJi92AW8SqPjxVwYsTicJmuvn+8er0VOpxmQh7uFcg6ZC+91ci7HH9r2xz5l3lk9HIJossbr3o+
	RDP/yDSNYnhlqLrmrCRT53d9KyZpLnHQHsNmnaITNJ9Bogt+6LDRJqPhkHYapo6GIlkOtXD8ywc
	gmPA81PuGaSW0Wr/JD+zUdacYuQHLfDE/EQcIrtf/HTbKP7rfNT4py4wvhKNV/6i4agtzQCpEES
	0zyv4LcXJL92RU9/5CBh3y6uJwjLLIuEu09hxW2GY=
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b41cb0c476mr14212923a91.49.1795602898261;
        Wed, 25 Nov 2026 02:34:58 -0800 (PST)
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id 98e67ed59e1d1-3b41cb0c476mr14212897a91.49.1795602897652;
        Wed, 25 Nov 2026 02:34:57 -0800 (PST)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm28776942a91.3.2026.11.25.02.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:34:57 -0800 (PST)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, kprateek.nayak@amd.com, bigeasy@linutronix.de,
        clrkwllms@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, zhongqiu.han@oss.qualcomm.com,
        Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH v2] cpufreq: schedutil: Run irq_work in hardirq context on PREEMPT_RT
Date: Wed, 25 Nov 2026 18:34:51 +0800
Message-ID: <20261125103451.1385246-1-zhongqiu.han@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=aPJlOr9m c=1 sm=1 tr=0 ts=6b06b9d3 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=7CQSdrXTAAAA:8
 a=EUspDBNiAAAA:8 a=m2RqmQonHRMwM0EXqw8A:9 a=bFCP_H2QrGi7Okbo017w:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: 1KZBwXbxZPurjH9jaqv6-vIOsU1Nr76_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfXzi/EmEv9pjy/
 gIN/hs+Ty+224W31YS+8HMNdScvfOgjHiu32ydsIKNZtqnv0cMkzyUxiCZMcJdLxa/TRc7EZHWt
 fPqT33jwdhu6122xhW+kHX+SGH7XBFoJrBKw7kydthe1sU37OaNSHGA+HRoJ70pJyPPylFp3oyv
 0hOHP1j0KSsznMhkdRGb8hn458dO6bcEmqSwAX2PLFC8CscBgK2FlxRQ5Swb4taec09gfL5Gk/l
 Nu8335/m7M0Z6pGLft53HieRqk1QxCs5MmwHLlJUj/G3m690OBQ7A82YwtEUK5rLEsaHLR0dY3n
 NKEyWV/OM1D7PzFzeD6nxoOu/a2jf69UHldJtgqVG5JuyHozaK/v6PiWIYl+K7H+sEpxzNAGWWa
 ZbqldRNwZcPVdjuxbrBY/pk4uKlpRJ7DskugXGrGozp3772bRPjsAwpHVLj9t4Ov0EisWwDzrAu
 SQAoSafDT3KoxxlMNzQ==
X-Proofpoint-ORIG-GUID: 1KZBwXbxZPurjH9jaqv6-vIOsU1Nr76_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MSBTYWx0ZWRfXwLcet0bEs3pM
 mZIGOr64odBC2fuxtn5RuWdV20jDOuOAmgC0kFs0oKEPg5Ad2EgR2dHlwK3OkgX4j8mwH1lg6S8
 iHdOnURSHkdsMZLAnMoKrJ1EA5T0e7o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611250041

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

Fixes: b4c6f86ec2f6 ("irq_work: Handle some irq_work in a per-CPU thread on PREEMPT_RT")
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
v1 -> v2:
- Add Fixes tag (Christian).
- Collect Reviewed-by from Christian.

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

