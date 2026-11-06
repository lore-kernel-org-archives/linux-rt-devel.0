Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952544;
	b=kmo2XKDcQMRyOdAJAISxT9QXLnuH9zAcZmEjW/LwQJXOVISct+pccqb03rzmmkKy1e+0
	 5VHWqR3LEvIEmQ4OTDiOTBbqNSYGq87QJVmC8pjKv8/YbXq/gIOW9kMaxp2isMYm9+h9M
	 uSR3b3wXMmXboXmGePaYzYLhHe8GVpAyTGyTmooe6UNbA+0iaZgXmiBPmhy29amXDZ78H
	 xqPsNtXNczqHA+X4RMfT1v1jXkFVG7hnxKOvD5mx4QH50kjE6Jl6nh1UzJHztC8AJcWeQ
	 9x+awrOr2L4dhwFIZ/wzRNGe6SflPToJcy2+l3vFuzA8ld7wlmnCz6KryPSkUO8c5YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952544;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
	b=lACkO5B7ezLc9nYjFo2T7fy4Qzg3xU7ZmUWHym09AoFTtkxFD+HuHgosFlfbU8ovR2zE
	 POe/uZi4+BkO6EEbeStR+XSIf3iRu4JS0jBl45j0q3ubLJ2bwEpUKTDqsGdqC2WgyFuPm
	 sz02r4NT81aaoyA0anecuXC27TR3yk1PRqLwxy3g0zAbF2Rtyv+ZyFvcuavpL5vrmmADt
	 yTW7Hu9cOWZzVfm/oB9JigFh9xl2+ft5nErQ76S4IJYbTKH/RRjK8xs7EsqiN2YRyNvhZ
	 CgFS5pvLO1lCjTrGQXF/23laEXfi9x7XR59VURD3x+TvoNJwv7ibV30JLjB6M1Q0yGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AbJ9Wy+B;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XulhoWT1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6FA606A32D
	for <linux-rt-devel@lists.linux.dev>; Fri,  6 Nov 2026 08:09:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B6FA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AbJ9Wy+B;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XulhoWT1
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A67Rngi3883509
	for <linux-rt-devel@lists.linux.dev>; Fri, 6 Nov 2026 08:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=3FN098lze/WreTU28PCuTM35
	o6JS53fRURS5tMMldcw=; b=AbJ9Wy+BGWSUUH9wM7T+vApfarg2d5aL2VfAHDWj
	GhUMKfrdKJ86TPGiMyH04IssKqbRH94JUhqG3Dw3RLpQdIi5mrg3/TKtjcR7YIkv
	76n2JttdfT4dE3IY6H1CeBA5znPQQH1w+HV8O2TMvmV3QM8I19301b8J3Svf/Jg8
	Zt2XDBTOqJhy4CYjdnMaqwjaea9pJXcUclsD71pOcHnJXeWOxN14faTP2Xw6E2dR
	sqS2I9k0CrzYh0Fq04HwIsNi8znH0/OHcPAzoqchi2oBCVaArDIfVufgsO0vqI8y
	JbqhazuSXwZC51WG1VA4lHvCO2DQAJL+AqRsMixPQZ2YUQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pb1sbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 08:09:02 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8812a952ef9so3553b3a.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 06 Nov 2026 00:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793952542; x=1794557342; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
        b=XulhoWT17S6vzoAtsAHpcoeiGdgCY5rwmOgHsnXQ2VUVzXHsA9Xl2MU62myxztA6Gu
         JaS8BNIjGnXSwr1M8DvYb7nvFiW77+Ft4ZYuFbMjt878E4Pt4ZoM1JBEuTrxLyMrZ4RV
         4hBLBGTe02mNh4BUc6Tg7VJdbY2OaJpzZHVoFiYBwuubvmnEA5u1GoRZzzkhqeUY8Kmb
         cpQPEU3C5gnsYkKwLdtdH0LxpPQz8kUtZh9pnzu3+brNRHFplosPXKry1ulK5PqlDQHu
         fhCseFsA28btm6A7/lwT7Epu7Sj3sZ3RgoJ+lJRzWctRtOotLCMDexFiBthikOG503GA
         tOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793952542; x=1794557342;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3FN098lze/WreTU28PCuTM35o6JS53fRURS5tMMldcw=;
        b=lSGf9MyuRjAhoKU9fEtMKolsRj8+bqikKp9GRF8BX5ivAWPA0+XhOEgr69EcV42RKB
         gS2JeCpVMZn2TZk9SQgkHVy31XwyVVFjDozHR8tIfBmTcQ+qVILFEfF8NBu0/G+9XgUt
         d0ii0caZhgk0eFk28BMMBgPF+Uo5K3cVnLVwd2icJCFqwO4bFeRts6x/KvM8fHiDwDnf
         lb5v8+GTFInMVLZAqc0QJgLWVzMmko7vu33wlvDfbDVb9WGSln/Vy2qUJoiC2xXsTgy0
         qLxDxmvIGvs8t4UM1ICPrUh5jBux/QfJy+ZGnkW3JQlAqxNarqXyUHfRTJM9G0sXfQ+h
         qoTA==
X-Forwarded-Encrypted: i=1; AKwUvBxik7uFdpn1sI+uZQMIGEsmdI7aVoU1G9Aj0rOoUXtHrhBiqFYHIP/GDxWu6XYo418QrYZ5tT63EQsqC8t+vw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+g/ljwsgn44NW5p090GicR4832oUIVwFRVnSZ3E2zRfA+Upi6W
	awAZKs2mmTQ2iZOuRQLAU9TlDp557gbkzxyGVAFWNNCAw0F3RflPfxrGhrPtNmn/jBqvIi0yzD9
	dDqaxBa5QWUolqYg/PK92EQHvjxDtA8Oel/yIeI1QPLMLQI9cm2Qr4JSR7UKPPAYAhMiKDg==
X-Gm-Gg: AYBFou14bl2ZFt03HX/0IYwfy9NsB8/MFyZZKLYQ+QpbC13WbvH6kzSENMUgNt9Bc5r
	2VK6Upawnrt7BBd5OWaOnzy3gFiwDk4Mx2ukMncb0Xm28GbAseJs5k4a00NxRPOtggqhVpN03FV
	Usr0KdrSU47JZsNAWZWRiDFYe4K7XUI1yXX3zd5KNx6KMZ5CwHlIbgoezKPBBQ9c8j0pe9I18B6
	YRpvvdqSg4ViOlx756TeM+o18HXr56ckwJrR1/PcRGxSz3AlqWedfr343bgYiEonFPZGs7I24fA
	b8/VNC8tE8Gkdfnu8wYASYGlRNzXMQbTJGU9B4dw9mxBF0GDs5ZQEFlhmIlDOJ/g+KkmbUC/G1R
	i81U7C0d2hqEW827TK5HP+NuW/nNHkWGxNnwSU4N94f4VwzOXixkeXD6fq8/t0f06qiIPTG2qvv
	QcurABLA2yb+frkiojfX8I751d6jM7v9wS93iuuIq81LVZunVjUiPE/nQZ2HJ+KBFpKcNWC7UJu
	6Mv3k/tizvMEu9Tqh2WmGEAMurr
X-Received: by 2002:a05:6a00:890d:b0:8a0:646e:7e16 with SMTP id d2e1a72fcca58-8b37bc5ead6mr1669814b3a.2.1793952541845;
        Fri, 06 Nov 2026 00:09:01 -0800 (PST)
X-Received: by 2002:a05:6a00:890d:b0:8a0:646e:7e16 with SMTP id d2e1a72fcca58-8b37bc5ead6mr1669777b3a.2.1793952541282;
        Fri, 06 Nov 2026 00:09:01 -0800 (PST)
Received: from hu-vishsain-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b35921dc8bsm375950b3a.10.2026.11.06.00.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 00:09:00 -0800 (PST)
Date: Fri, 6 Nov 2026 13:38:50 +0530
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
Message-ID: <au2LEsJjuOgKit1j@hu-vishsain-blr.qualcomm.com>
References: <20260909-drm-mis-next-split-irq-v1-1-89bc9c512c53@oss.qualcomm.com>
 <20260910064723.pbZP3vic@linutronix.de>
 <aqP3lDjzzsbFNly5@hu-vishsain-blr.qualcomm.com>
 <20260915073614.nvT9zW3S@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915073614.nvT9zW3S@linutronix.de>
X-Proofpoint-GUID: BuRMdQ1oQ19Ab9c27m-wmVCXifCVRm1B
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfX0MGX8tHv57nC
 Antf5BA2bgjZEMZ8AlTZzsTY7MMR8ycEO2O40GoL9W/VPTX2PYFdlrG+NJeaA1uV6aH2jtL3zSI
 0zqXxXdFRZtRR3jTRbBcVk+KHuYRaaM=
X-Authority-Analysis: v=2.4 cv=LIrz05W9 c=1 sm=1 tr=0 ts=6aed8b1e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ZNqZZCZIVyXZx7ky4tIA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: BuRMdQ1oQ19Ab9c27m-wmVCXifCVRm1B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDAzMiBTYWx0ZWRfXxAdm0ahrIl9a
 jy7PmgqNDKAaQUqD2XXem8ftP0PCYYodNfJlSD/bDMr5kxetw8G1AVH65v0GfRA1kV6z/b4RSTe
 8hIEN9lFwc1Jgm6Ryx7na7CRRUKpYyo/gWOzOz+XgK1Srhaw/PJWuV5/eD2kzhCdRppzn/v5dLV
 X6TguDI/SWa1CuCh23uYUUJgTiVn32flqlXLi/sy6UURuTSt0ZuICH0LLKC09uZ7OUfQvJYnyyX
 D9lQfnY7UY1CqbnVG2dvpv1fxv4xAZ0hhqcH7ql/PydR6wOpmdJMyf1/rKM3Z49NUPM/DQxCN1C
 lkBCOAg26PK7ngWHI3n4MzwhQXMt7S/1IhscGWhxybMZg2OatLtEoCl+Jr7MAUO36vfhPSisk7X
 Kq7fOrUILdCSKsYXTjG/ITl2ubaWaUXO4engE6sKxRZPKoj9oIBwkGQwORXrMkHE+gvYBys02UL
 /LnkgsorvizEh+kfmEA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060032

On Tue, Sep 15, 2026 at 09:36:14AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-09-11 18:14:04 [+0530], Vishnu Saini wrote:
> > On Thu, Sep 10, 2026 at 08:47:23AM +0200, Sebastian Andrzej Siewior wrote:
> > > On 2026-09-09 14:22:16 [+0530], vishnu.saini@oss.qualcomm.com wrote:
> > > > From: Naman S Thaker <namathak@qti.qualcomm.com>
> > > > 
> > > > On a PREEMPT_RT kernel, dpu_core_irq() runs as a true hardirq handler,
> > > 
> > > *why* is this the case. The code you replaces adds some ifdefs around
> > > request_irq() with 0 as flags. This does not make it run has hardirq.
> > You are right, the statement is incorrect, i will update the commit msg.
> > On RT kernel, the dpu_core_irq() runs in threaded context by default.
> > This behavior is changed in the commit by calling devm_request_threaded_irq with
> > IRQ_ONESHOT flag only for RT kernel using the ifdefs.
> 
> The why would be interesting. Usually things stay threaded to avoid
> locking issues down the road.
> > The irq is now split into two parts for RT,
> > 1: primary handler which does not use sleeping locks, and
> > 2: secondary threaded handler which can use sleepable locks.
> > For normal kernels, the request_irq() with 0 flag is still used as-is.
> 
> If the split is properly done for RT, the non-RT variant should be able
> to use the same without any ifdefs.
> >  
> > > > but it dispatches per-encoder callbacks that take sleepable locks
> > > > (spinlock_t becomes an rt_mutex on RT, and some DRM-core locks reached
> > > > through vblank/CRC/writeback handling are sleepable as well). Sleeping
> > > > inside a hardirq handler is not allowed and eventually crashes the
> > > > display, which is what happens after running GLMark2 for a while.
> > > 
> > > That is correct. That is the irq handler are threaded by default and
> > > only non-threaded if explicitly requested.
> > > 
> > > I suggest to stick with non-threaded by default.
> > > There is only one request_threaded_irq() as far as I can tell and this
> > > msm_dp_display_request_irq():
> > > 
> > > |         rc = devm_request_threaded_irq(&pdev->dev, dp->irq,
> > > |                                        msm_dp_display_irq_handler,
> > > |                                        msm_dp_display_irq_thread,
> > > |                                        IRQ_TYPE_LEVEL_HIGH,
> > > |                                        "dp_display_isr", dp);
> > > 
> > > and its primary handler will be threaded on PREEMPT_RT, too. So you end
> > > up with two threads here.
> > You are correct about the primary handler in msm_dp_display_request_irq() being threaded.
> > But the request_threaded_irq function in msm_dp_display_request_irq() is not modified in this commit.
> > The issue fixed by the current commit relates to msm_mdss_irq crash stack below.
> 
> Why is it the way it is? What is the issue in the stack trace below?
> This is not described, is it? Your cleared the top of the report.
> Now, msm_dp_display_irq_handler() ors the return value which is wrong.
> You can't return IRQ_WAKE_THREAD | IRQ_HANDLED and expect the thread is
> woken up. It appears the handler is fires over and over which implies
> that something is wrong with your primary handler.
> 
> The way this is requested you supposed to have threaded handler and a
> secondary-threaded handler. While msm_dp_display_irq_handler() is
> invoked as threaded the IRQ chip masks the interrupt source. If it
> returns IRQ_WAKE_THREAD it supposed to mask the interrupt source because
> the IRQ-chip unmasks the interrupt while the secondary-threaded handler
> is run. It seems this does not work as intended.

Thank you for the inputs, we are further debugging this issue. The crash accur because of
increased unhandled IRQs on RT kernel, will share update once we have root cause of
increased unhandled IRQs.
> > [  152.108462] Call trace:
> > [  152.108465]  show_stack+0x18/0x30 (C)
> > [  152.108477]  dump_stack_lvl+0x60/0x80
> > [  152.108484]  dump_stack+0x18/0x24
> > [  152.108489]  __report_bad_irq+0x4c/0xec
> > [  152.108496]  note_interrupt+0x340/0x394
> > [  152.108502]  handle_irq_event+0x94/0xa0
> > [  152.108508]  handle_level_irq+0xd8/0x16c
> > [  152.108513]  handle_irq_desc+0x34/0x5c
> > [  152.108518]  generic_handle_domain_irq+0x1c/0x28
> > [  152.108522]  msm_mdss_irq+0x68/0x144 [msm]
> > [  152.108654]  handle_irq_desc+0x34/0x5c
> > [  152.108660]  generic_handle_domain_irq+0x1c/0x28
> > [  152.108664]  gic_handle_irq+0x4c/0x140
> > [  152.108669]  call_on_irq_stack+0x30/0x48
> > [  152.108673]  do_interrupt_handler+0x80/0x84
> > [  152.108678]  el1_interrupt+0x38/0x58
> > [  152.108685]  el1h_64_irq_handler+0x18/0x24
> > [  152.108690]  el1h_64_irq+0x70/0x74
> > [  152.108694]  __schedule+0x6c/0xc9c (P)
> > [  152.108701]  schedule_idle+0x20/0x40
> > [  152.108705]  do_idle+0x17c/0x2c0
> > [  152.108710]  cpu_startup_entry+0x38/0x40
> > [  152.108714]  rest_init+0xd8/0xe0
> > [  152.108719]  console_on_rootfs+0x0/0x6c
> > [  152.108726]  __primary_switched+0x88/0x90
> > [  152.108732] handlers:
> > [  152.108734] [<000000000cabe59c>] irq_default_primary_handler threaded [<00000000779fd542>] msm_irq [msm]
> > [  152.108859] Disabling IRQ #246
> 
> Sebastian
