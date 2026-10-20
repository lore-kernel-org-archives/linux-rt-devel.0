Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792476209;
	b=QvwhhTr8H1uGTmv6ij3iw8nuL0nVlSUBG8wgKKzXGGZWtdaNWPTzXnAbCbSH7vePsNUp
	 aWgdgY2rm7+GQN77CHNCFCsELcyvOKGhlm4bKGzF28PeDM9ScbgCXkrQwvpm4ELJ/yiVU
	 qdXquDREpNIbd/Mhz3HGfqR+ME4q91dxZSx+oBBN6U9DyP0ORsSbgJUyqbYQE9l/CoHG7
	 PMyngnNnRJ6MMlZ/ps7zaXdcVqgoIFRvikt55aiWyIJ6GGNE8J4T4a5CtCFIhVdkCD8a2
	 mBz6jn8g5tKRfLKZp8SoN0MmYZSQyOvola55xx7v8ZQTqGdVTdf+Bh30OYa8fkfDbVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792476209;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=p8cJylFC2g4xbGQA1ArE9XXjG87bsiOPk+iTHEazeWw=;
	b=Rc9/sTGUP/TrB+OWs6m1QyjF9FeMGdTWLJ0bdd/SJ46ykvnhw4RlnsoMwiczh7pnNBde
	 svb/F5bMGs/7u+nF/06cU0uCOC7eOuiHCpzx2TU2n1gRJkA/Q2GOxrA/BCAchUtEUh9u4
	 gaOL9prb+KMkdcrLrNVEXKCUV7RSyw9+wM7VP4z0eMzTJxI+BIoPswT5tY4YfHaiht0yh
	 7rkRx2f383b557Ae6KySGwc5MriEKz6IDCprn/WL55ybtJOeuemnrzs+ettx0dWrRSYba
	 NhRGJt7T4eleJ3g+Ky+qr72MHtheHpRFbHB8OoIPyLOp+sf62VMGFFVvwzqI8CxwHeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lsyykRCx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KyIi8p2I;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DAE606A31C
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 06:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21DAE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lsyykRCx;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KyIi8p2I
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tbFG3807765
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 06:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	p8cJylFC2g4xbGQA1ArE9XXjG87bsiOPk+iTHEazeWw=; b=lsyykRCxmk0X2yMV
	fC0SGhNT+34pD5YUjJp7LEeqLhnm/671lV9hjYQ7GpUiL8JdhBFjsQ1BkTneatSq
	OzcBJMLf9+nfPk+yWvMpQR9N7HVoD1SG+dbYmOyF6Ci5v2d9gn38caRuw+SGFLXO
	TNdE+sMV8Hm8ny6ho7RzOJ0Muqn0x+9LQvQIEWYd7tsJ/79v8KJY7c03/CNtkLVY
	rh4lAGKQNDwvT5ouWvBTXUJ9Nd0YvqMJzRncjmuDIqENR0pkF2EU09pp8wHNoYzp
	TvnVJEXqhrMDgjoojBFvfJzNPMhs17mhXMI36tl269a1kAcA2lUkz+mBZO1OOEyO
	IFIJjg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5p93g2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 06:03:28 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93edac5877bso54721285a.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 23:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792476207; x=1793081007; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p8cJylFC2g4xbGQA1ArE9XXjG87bsiOPk+iTHEazeWw=;
        b=KyIi8p2ICZg0yUZl1B7RA+sjbkTwPK8sUdj3gvxbD0caZXFZfGGQ/KY5ige50KKXoz
         NmtZC+PEyo/KQOtwqfN8MQioZad3202fkcZpnrtXqoo6hOe0SSHWErdpmSzulo0TBMsP
         R0CRqeK49hTXtR89gzFLu0IwHZHQcwh/PzBlbbgAxYK8EYxMSpi3YN1YZ1HLckE8tIlT
         Kfblg3DpqlVOc0oOjGLJIuCSg78xRl+YJdIE3SZFYMP+WEup56MpZAnOjnxQmvAVs54A
         l+ymfrkqWS87cxWNIpig2nYNn02xoVu9iLAHB4M7EfHSbWf4b6rabDU3XfKVedApHOI+
         sZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792476207; x=1793081007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p8cJylFC2g4xbGQA1ArE9XXjG87bsiOPk+iTHEazeWw=;
        b=j6o8WTEKDefU2fTkhFzQ4ruaOPFUCIkIFdIj+On+TeIzy9hmZrttGZasp/ikhSD9j0
         Tgwl3WtHHI65CULn0zPmsu+mR1cDdle7M9HmOaPH1lln26ejaUFELf5UeLPC4QlaLQlk
         U29mHpp+4ahJLImOyfa/maCYAqvBGwvhhn879/lmX60psJhDU/o+QAUeQrLeA6Ubll3p
         OCt4k+pkR9COfz20RmOvXmHG6WfO68HJLC+EgWgViUgfiqglxAnlwkq1m7XaGXQ+nvqY
         ocVMh1tMi7Kaom+ks7D7WHK5OWVPjh5Rk8DcsoVsB2ud9nsydQmmHHEvuBkN1XymowS4
         n+eA==
X-Forwarded-Encrypted: i=1; AKwUvBzKSCX7lWu48/Vm08viC+MpfzzLWii192KRpeSTrVy81XMsfsVFJuL6taUfzLZ4X25CPRdh+A2IgzNu4oJrGQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYJ8nu59YgKIruFwq0JaoBLttaqZwhk5QEm2uP6iBLyWfx50AJdE
	RldPUnhOeo0C/9+T58FOGBiHpPulURDmehmUgOC9mX4vsChIC95dTeaNXDZtNnq6T2KEJLeHJb3
	yP8TQEJID4ieIwtVnEQrV2QflWGPEjzCtz1YnfaLoSgGQgbgbQq076VTkjjOhuTWSfq+jWg==
X-Gm-Gg: AYBFou38mL2YqjAMzjK7ZBXbLaN5WAew37JfLhnUHLaYIEV+imMHmnLUwb8g4zqs115
	QKBYJRupqdNIF4Mig+ap18EE4RJSnKLLDsjR54+p6wyyVRqJ2N56f0bPJKyMrbp7k2cAqT6eqBg
	grYJoUlmyJEpBSiii+QZsiXlYFwXUnsCKDcPZYnv/jDa5itNSFq6nKA2cmHaRSIYJnDI2I4JGBb
	tlt7Dp15OS0kjInWKp6q62Epi6QzFCUwXAAQxvI4ZwcvDnjoyDuOJmILc+eZ9361MElFOZkbFvs
	u2/IOrCNEXb9tBCTPnmwD/9AhDpxXUvq0y3Rsk11H5RTP5LCPd2nxjOaR28tOKzmZHpz7uLqEO8
	hbPLRlrC3fB8ldPHgzoExFA==
X-Received: by 2002:a05:620a:3728:b0:93e:5a3f:ac13 with SMTP id af79cd13be357-93f29a0a71dmr1879895785a.0.1792476207134;
        Mon, 19 Oct 2026 23:03:27 -0700 (PDT)
X-Received: by 2002:a05:620a:3728:b0:93e:5a3f:ac13 with SMTP id af79cd13be357-93f29a0a71dmr1879892685a.0.1792476206592;
        Mon, 19 Oct 2026 23:03:26 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c409239a167sm448288766b.84.2026.10.19.23.03.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 23:03:25 -0700 (PDT)
Message-ID: <bbfb11f6-0a8a-4952-b372-fa3782c96aef@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 08:03:23 +0200
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] soc: qcom: spm: don't clobber the SAW control
 registers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
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
References: <20261019-fix-qcom-saw-v1-0-9c7ba3fc2493@oss.qualcomm.com>
 <20261019-fix-qcom-saw-v1-2-9c7ba3fc2493@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-fix-qcom-saw-v1-2-9c7ba3fc2493@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: nttE-QnKqfryGIPOswadJMgXoqefL4P5
X-Authority-Analysis: v=2.4 cv=fb84WEQF c=1 sm=1 tr=0 ts=6ad70430 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=WNvXFvV67iztUfGrp4YA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyMyBTYWx0ZWRfX2fja3fxfgo6L
 sBaDpEWDS70iw5QNgb9aDetiClV0kwcFbb+GvL1X+2TkPHlVUrrhENRABGfiSMkmpRw4tKkMhvA
 RAHLP5vPnjx7XmZbBkfdHHSWXHtTXRHF0FVC+x/zCy5v6xZdZNsoN7f1ctiI1RHzTJWZtwXaoDn
 TmtwK4BLOESmy2TjeFsN+0pNwQF4+5dejHW3VZDOUQ2kyGCLR3L8V052WkmX03mEYfljvjuXBo6
 kYZmzr70PAG10QUaPSiYnq0TnHNCn/69iBljiP7BnmXNH/dRmuJpQH9ew9ZNMS5Uvq6arSxQE69
 cYs+uSlnyBLlCJmCKpj8YY+pabFrRPXSSBJR3GswLquNXwvfm9E5xXrhFX7GBT1P33pjV4PQvW2
 /knl/CNLuINj+uyU3nSKo0pqsDwY+E8dVp+C/w4sTl+hxILAuZZstCAlvCNnReG59nxn2JYf3wV
 3u3EphhbR9mcD1E1Vug==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyMyBTYWx0ZWRfX+ogZSobYu6qp
 UNzqZ9b5YbymuPE4cpSS3Ayz2q+5X/V3/l1iHrjvgsLZz48mzJndBRPJaI2s0v5d8XIIea4/IDJ
 XHcN2A6ML5Qs8KA+Q27sac41taTX4f4=
X-Proofpoint-ORIG-GUID: nttE-QnKqfryGIPOswadJMgXoqefL4P5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200023

On 10/19/26 4:39 PM, Dmitry Baryshkov wrote:
> The SAWv4.1 and SAWv2.3 register tables have no sequence entry, so
> probe copies the all-zero sequence buffer to offset 0 instead, wiping
> the SPM_CTL, SPM_DLY and SAW_CFG values the boot firmware programmed.
> On MSM8998 the firmware then still powers the gold cluster down once
> its last CPU goes offline, but never brings it back: PSCI CPU_ON leaves
> the first CPU pending and the SoC hangs or resets.
> 
> Only write the sequence when the SAW has a sequence entry, like the
> other registers.
> 
> Fixes: 13e72c3e2261 ("soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

>  drivers/soc/qcom/spm.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> index d41c94d32b51..6f2f14eb9022 100644
> --- a/drivers/soc/qcom/spm.c
> +++ b/drivers/soc/qcom/spm.c
> @@ -528,9 +528,11 @@ static int spm_dev_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, drv);
>  
>  	/* Write the SPM sequences first.. */
> -	addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
> -	__iowrite32_copy(addr, drv->reg_data->seq,
> -			ARRAY_SIZE(drv->reg_data->seq) / 4);
> +	if (drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY]) {
> +		addr = drv->reg_base + drv->reg_data->reg_offset[SPM_REG_SEQ_ENTRY];
> +		__iowrite32_copy(addr, drv->reg_data->seq,
> +				 ARRAY_SIZE(drv->reg_data->seq) / 4);
> +	}
>  
>  	/*
>  	 * ..and then the control registers.
> 
