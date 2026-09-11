Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C54756A8
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789130658; cv=none; b=DrZIe/3Jsx8Zz032IkDas2P8D2JDougsE7VS3OCc1z3ySRRc/zY8eornSmyxECV8vCVPMMc47fA2KDvbnNdSJNdkzOnbSJ/9PAAmtYqKU0y8dFqsgDrWk0URUcpJP68epYw21Y/Q09VMKmoq13fZvjE2W/cTPWI7Dl65gdwhN2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789130658; c=relaxed/simple;
	bh=Iw8u2HFgGqDAoQrrT9wzoBb0ozZH/XWjDz6cYa9Fox4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnB26G8JmHZSTeR1AwMkee+B/NCsOqa52uqVL1tFVSTl8D8KvK0bSmAe9P5oPu25I+eiiqhszf2qWU2v/JgYl8YWMzYkA5YAhqRWB8/lNYLztiAFhmyLoRL3OjNKW23asXshcXSHqhJ4w+p1KXxOFLCk4462fUDxy6mOzKcuAUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NjK7fcb6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dUQj+kKn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NjK7fcb6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dUQj+kKn"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BAq2s63932286
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 12:44:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hs3C87rUc37Br7hDul2xSyhF
	h9hB6GXOl4E84myixsI=; b=NjK7fcb6JPtbo5k6auGunh1/s6S8cSB7/2xfUCb0
	geBR6XfxyIyAv/YgcP8Y+c9tuKr9gYAo3B6JafTG8Heot7v1jkoHq+1UeI5/8ix4
	uIuXBf3NIewBEGLANgLEDH4Iv91nN3YQ4OrelX0svTbAYm0QAF7onmGlMv1xOTv2
	pqTqXF1qOaUn2TSkn2Zx+Zy+UlzWsOMcW6qV/pxCY0hCDp6ut9jyKGe+oY6sv/Jx
	mJYOXFPLWKjH6vg1XX2p8L37maNfpKt26iRisfXiPNpqJvnAdB1w7P207DHsAOw9
	m9cW25yCDc132GIie1OvaXAGaotgkwZaoA4TdtHSVtUrIw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmbd51qdx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 12:44:15 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84e5a0317a5so92067b3a.1
        for <linux-rt-devel@lists.linux.dev>; Fri, 11 Sep 2026 05:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789130655; x=1789735455; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hs3C87rUc37Br7hDul2xSyhFh9hB6GXOl4E84myixsI=;
        b=dUQj+kKnKLiCTmXuSaBjw82UtGer18vSLcK0GmCDZpFf1x2QBKgu0mrdDwPqwvPeeU
         2l4jT7BOKvogzAVTK501sngx4wiGVk6bJ6L61dchgIdsrQhkUmTyzvxfTK42/CshYZui
         DPnFNH+RL1MarzgwPxhi/1yQL2NHNu3Bkv/akxci5/WYSJqrGGxb+IA4N0Rtq+XkOlrd
         rnnc4CSxGvaznhbausiPEE5sqb488QUrLCDvzFF6/GLzEvbNV/EPlVvAsAdAnYTlnP7N
         GnWgSHR0xauCta8MaLjoR/d9mfX0HsszCTSwzHyj5ldUIJwJy1a2O6OPROmmWm//3/Tz
         aVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789130655; x=1789735455;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hs3C87rUc37Br7hDul2xSyhFh9hB6GXOl4E84myixsI=;
        b=kg/CsJnKGOCIsNpfONE6RvpnI18s0yoRbtDNbNsDbDQn6hyflBCOJ5pX/QtlV16Q96
         CHefOplIFKiW9szQb/YD8vQx89cPYG35WbPdWu+UqY1kalCRMUP1GCScv4Xl8t8HmjP3
         XQt2vVLjO5VsCvttf/g1DUMCCOeaE5Z1j8ZVmwmaY6Z8NhlwpLgNuPYYDlP4omRVfViQ
         XPmgL6UIUqXUeiREVOiZd8a+2v5qJTxMS6r/dRkm6lWrle1TibcyE4IJKW712zF4Q+9G
         mDuPn9jaf/0d2dgKIuBONY3obZJ2A5DLa2pwA5/isI/s+8D17P6klFu40lqs9x/bQnL+
         0Fcg==
X-Forwarded-Encrypted: i=1; AKwUvBwS1nhWI/bPJgVYAbK7m1FpuhoW6jMv9MjGB8ppx8Lio7D6DO2dr976yVaGE6S4CjrSTddjCV0ncqdG2pMkKA==@lists.linux.dev
X-Gm-Message-State: AFuF++k4rUC5aSWrH0Nw5j04O6SKP8aCHsivI3TLvLUQyEmoM6+Qvicl
	nARgVGEoISlrhuhzBCvJhvaOvKvE3l91SlByEsWuO4NiCdAQXkDURj4KUbMdksXL0m6M1Pwr1Uz
	Go6Osz8LY7jMTgZQWov8wbOQ7CMF4JEC2RRkOcc+qI7JWbwZaMJfnlRMZAszrkZBFc907/A==
X-Gm-Gg: AYBFou1inSPkXUttgW7fr4svgzEfT5iz9j0EgZizZBs4jSBwzoqgModtax3FQuG8M8n
	+uGauUnvCAVAdE/aJRMoZm3qcWBD1+BcX/IH/TkZHNuOKRniz9RQvW6essY2EFCTSXGErDZJBk+
	MNNPigH+eGB3P9NITUKV6YB7+7uci7rwjXZDk/EBrWMmgTTct39auowK2McW8e2Ad7UeE+nbgoz
	4rdgena1o2xf1asxbLjkdoTh4u3FbdukE2605c6OzlyPo0fOk3u6um45uW3fMYjnvH0TI68IVV6
	2ia9911EN7U6ZlitKP6pgSHQDKKbaqR1zIFepzBCQNfeV60e12tHYEPQ6iJxvp8Gn/4w/5oOoeK
	7FY6huXYJs+3gZb18Yh2joayEeG6rvZ0jv2mfJpGuUrXLB211mWdb5wyCsYvJrJLThFXNKVJPTc
	5XAm+pdVsMD5qMeNQcU05a
X-Received: by 2002:a17:902:ce12:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2dd29e0eb11mr52067685ad.0.1789130655007;
        Fri, 11 Sep 2026 05:44:15 -0700 (PDT)
X-Received: by 2002:a17:902:ce12:b0:2c9:ed4a:c3a4 with SMTP id d9443c01a7336-2dd29e0eb11mr52067185ad.0.1789130654445;
        Fri, 11 Sep 2026 05:44:14 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3f0faf19sm3636485ad.12.2026.09.11.05.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 05:44:13 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:14:04 +0530
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        Archit Taneja <architt@codeaurora.org>,
        Jeykumar Sankaran <jsanka@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        Rajesh Yadav <ryadav@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        venkata.valluru@oss.qualcomm.com,
        Naman S Thaker <namathak@qti.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/msm: split DPU core IRQ handler under
 CONFIG_PREEMPT_RT
Message-ID: <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
 <20260910064723.pbZP3vic@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910064723.pbZP3vic@linutronix.de>
X-Proofpoint-GUID: _Kx8cLfa-rKHpL4d1EZvcdj1MJq3vNg9
X-Proofpoint-ORIG-GUID: _Kx8cLfa-rKHpL4d1EZvcdj1MJq3vNg9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE3OCBTYWx0ZWRfX96Qjspd6q9AP
 ek9tITYeyWheUhpuIJ99wIiIkzAYvlnDdQ7XuSAdd6evbL/rU472FCHpd1c7F347onghJHKohxt
 ppHBodQBtPecLBHunqNs5qc/gnowDPs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE3OCBTYWx0ZWRfX5Q3S2MICiEi1
 4GspfJ7k4Ikf680fBQDP7dy3qcA9kOZ53hqbz8XHR7cCcgszNVCmrakOU4hcdhM7W9SAKHqGnx/
 4zphjpvmNuwZlSplWUBDpleQ1uqRWgqr95pE3XCezCWDZ7G2IiH9fyHCFgOmP8IqcAWgO1d1G+e
 w3Vp+zyVvgDAZJZuKKLpLaAeKckpw6DPEAZEnKcypvpDZyBU2xoRluOh8jAor6FaFi9lPV2VORv
 attFKWC1r8SSwNzBda6tflgBJMuFK2oTTETotf3UmaepeWjA+N/evuYI1rK7AwW2RtYNN0VeGbL
 H2qFQZTKTTqL/f6JolhUDADuApfmFJlPV0z/5aH5ZaR373MnlfeckQuAzJYLeO8RMEWzwHBY07s
 OP6v/iW6lvqfcjzuTzJ22m0HrGBZS+BiD4tofUDk1g7vLmmh72fPmMkt2RmPybrHN7KhsaguAQW
 fAgCNlVi9z96Z575/kg==
X-Authority-Analysis: v=2.4 cv=db0VTnXe c=1 sm=1 tr=0 ts=6aa3f79f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=p8fm3qIaiwJ8G5vN5j0A:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110178

On Thu, Sep 10, 2026 at 08:47:23AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> > From: Naman S Thaker <namathak@qti.qualcomm.com>
> > 
> > On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
> 
> *why* is this the case. The code you replaces adds some ifdefs around
> request_irq() with 0 as flags. This does not make it run has hardirq.
You are right, the statement is incorrect, i will update the commit msg.
On RT kernel, the dpu_core_irq() runs in threaded context by default.
This behavior is changed in the commit by calling devm_request_threaded_irq with
IRQ_ONESHOT flag only for RT kernel using the ifdefs.

The irq is now split into two parts for RT,
1: primary handler which does not use sleeping locks, and
2: secondary threaded handler which can use sleepable locks.
For normal kernels, the request_irq() with 0 flag is still used as-is.

 
> > but it dispatches per-encoder callbacks that take sleepable locks
> > (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> > through vblank/CRC/writeback handling are sleepable as well). Sleeping
> > inside a hardirq handler is not allowed and eventually crashes the
> > display, which is what happens after running GLMark2 for a while.
> 
> That is correct. That is the irq handler are threaded by default and
> only non-threaded if explicitly requested.
> 
> I suggest to stick with non-threaded by default.
> There is only one request_threaded_irq() as far as I can tell and this
> msm_dp_display_request_irq():
> 
> |         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> |                                        msm_dp_display_irq_handler,
> |                                        msm_dp_display_irq_thread,
> |                                        IRQ_TYPE_LEVEL_HIGH,
> |                                        "dp_display_isr", dp);
> 
> and its primary handler will be threaded on PREEMPT_RT, too. So you end
> up with two threads here.
You are correct about the primary handler in msm_dp_display_request_irq() being threaded.
But the request_threaded_irq function in msm_dp_display_request_irq() is not modified in this commit.
The issue fixed by the current commit relates to msm_mdss_irq crash stack below.

[  152.108462] Call trace:
[  152.108465]  show_stack+0x18/0x30 (C)
[  152.108477]  dump_stack_lvl+0x60/0x80
[  152.108484]  dump_stack+0x18/0x24
[  152.108489]  __report_bad_irq+0x4c/0xec
[  152.108496]  note_interrupt+0x340/0x394
[  152.108502]  handle_irq_event+0x94/0xa0
[  152.108508]  handle_level_irq+0xd8/0x16c
[  152.108513]  handle_irq_desc+0x34/0x5c
[  152.108518]  generic_handle_domain_irq+0x1c/0x28
[  152.108522]  msm_mdss_irq+0x68/0x144 [msm]
[  152.108654]  handle_irq_desc+0x34/0x5c
[  152.108660]  generic_handle_domain_irq+0x1c/0x28
[  152.108664]  gic_handle_irq+0x4c/0x140
[  152.108669]  call_on_irq_stack+0x30/0x48
[  152.108673]  do_interrupt_handler+0x80/0x84
[  152.108678]  el1_interrupt+0x38/0x58
[  152.108685]  el1h_64_irq_handler+0x18/0x24
[  152.108690]  el1h_64_irq+0x70/0x74
[  152.108694]  __schedule+0x6c/0xc9c (P)
[  152.108701]  schedule_idle+0x20/0x40
[  152.108705]  do_idle+0x17c/0x2c0
[  152.108710]  cpu_startup_entry+0x38/0x40
[  152.108714]  rest_init+0xd8/0xe0
[  152.108719]  console_on_rootfs+0x0/0x6c
[  152.108726]  __primary_switched+0x88/0x90
[  152.108732] handlers:
[  152.108734] [<000000000cabe59c>] irq_default_primary_handler threaded [<00000000779fd542>] msm_irq [msm]
[  152.108859] Disabling IRQ #246

> Sebastian
