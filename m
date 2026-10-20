Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792475574;
	b=bdj9nL5mGxySecYg6SKQLLjdDz7I+x4eUTla/oNQCG+5hN7JZfLvCKgX0htsG4gJqIlr
	 RY7jUroOSngtGyBGwfuhKZH3evm1jc1O+Ihtpmgkr/AMk+bn3VIAqY0R+feJD/NufvGFE
	 CRUwVejSt6KAzMd7TyXhCbQxewL85//xqoElua3k96dMIYqEA4jfD85rKy+lejR1MRueL
	 7Vu+tkrHxMKk7kZh+pvB0Z0vZaTUi2ia0MXxQhusgTPNK5dq5T17ouuhL9usZe0/wFa6c
	 fTrA9Kqp8BXzJvlJW0bn/OK7dTDyjb7tdKRjmO6zxSZy/+BVWYtwLeiz/aXOVC7XQNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792475574;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RN3wmZAM7GFWTpaZKW6y51wUf6lXSD82i4H184b/1FU=;
	b=C17ILY8tFTu62Z0j1pOTgJRa8K9elc/Bbys3C0wjG/TzGjXu4PjBDCmvzcjrHCAyKXme
	 agH7o8/ZJ9uBOnW7HNZbyfU/5tdSFwrvwIDefuz7g2BhwpDT9hMTDYl01LkAQmXJctdpI
	 /XDP0J6uoxSD2QPPCYNTNs/223Ffi6ZkKS8TOJNEEyWqx7Dnv4rnqR/1xjVxSBO0Z5Ncr
	 0BJrVjRgNRetFOnMhL5kUURvZTl6uKm1blxgi6YUBAVfOfQO7SnH5Peb32qyLfARgFTBn
	 QSnRY00EBz10mHYUI1wq2YDC5fNfvg4kDxcRbSwuKvz6SX6H8EnrZJVh/cSmVDHSZwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P93bWUie;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="d/CF1S8P";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85418606A31B
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 05:52:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85418606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=P93bWUie;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d/CF1S8P
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K0tgM3620789
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 05:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RN3wmZAM7GFWTpaZKW6y51wUf6lXSD82i4H184b/1FU=; b=P93bWUieowygmN7l
	UjmKOil+5SZeXhIw1dYC+/jGPIFaWv8szg213Dsvhax7WMGMFhe0Jp63y7xfEvJ3
	oIVkWSH7+CPiVQelteFqAkcc+bkDvsipf/dcNgWvluNiOwnEf8Uqv1DboWnlhq5T
	2yDdGkxEgRqSIMTjE7Dn6qfHvA7EfMADYXvkjhDTmuCIn4X3kX/bU8AMto0LnYb/
	i1Pz8fgSVvEImcJ19/g5NAOtAjCKx7lJV2Hr7OVr5+YSZfqwrVcYIiqg3sSoh7CJ
	e3H/FHj4wEneKXD9OkdOuqpsFslM7oizWb7xTxAwv8wjuTe0ykC+hqrlBXAaRUT1
	2hbSig==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ns0p7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Tue, 20 Oct 2026 05:52:52 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f3960dca5so41161585a.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 19 Oct 2026 22:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792475572; x=1793080372; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RN3wmZAM7GFWTpaZKW6y51wUf6lXSD82i4H184b/1FU=;
        b=d/CF1S8PNKjqO3GnSL8MZ0JrqkIcV3Uzou/0TyZo5mY42xhZgzyhXilWXoWKL9pDjK
         kaIhGmEQoZxc/u5Yd2htD/AUSXdDefDUIX17zJRHMFmGbPJmj8JZMrgyUCfJyisLONpo
         VmsCpSSAw5YtoqRWZW89jzXfH+tESWxEheuKVmY9PEDsEOhCpDyqYyz8xaF4sSI1bNoD
         PgmbSQEFtaq0uGuhiAvhF5/hr5L/fehcaDlW7k1JOWCwtcj+bkY01m5+fBiJFpQfQN3X
         yeHaMdaG4gVgonHVqYFTkGxVIWFLdoRUldifWOlKXzJrVzytjUv/qvy3alpDK4EXNnIN
         xR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792475572; x=1793080372;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RN3wmZAM7GFWTpaZKW6y51wUf6lXSD82i4H184b/1FU=;
        b=QAgbmAOktCSnXhgU1YK64yGmpFDVU7cvGTyTI8db1aPDby6mlWMNtKLkkEcHPaMDZ0
         DvQqrn/Yt/KPO8JI1QjBCnnEaaiEaeh9QoRkZ7LKQMaKeKe3s1N6VmqOwSFnvUII7d8s
         njznnt73h/E2S7tDtHjI2x/XC9ukN+0z2/n9okxYc58vocOFRBqMoRhuBnIfbrQ0s8YU
         ys1kFJ8eOkQF8MtxeJpcyhtCLQPurH0N3D19l5Xs4AuMwgNYMDq2HIcHpT48VBXQWD2y
         sqmC2wlrHL1pn+bDlvhLIhzU78X35BDgzeO6BPhcRBPXfT4s0+ryJi9bDb01LP4e9I+U
         7poA==
X-Forwarded-Encrypted: i=1; AKwUvBwXHi5ogIw1BdXx5QbfpRia/b2IOXYlFFCWsyzcupbAM9Mp66EhZiVkqoqhrktWn9NrSMhf5Qv1GOWu6aJPjw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKzm2ADzOKAE0g8JqV0ASwJ8mQlntXF5nG3e8cymksUdRnK5DYG
	gcqr6OY71QHq79F5JnrcyS783NjaKmRRSZPfWjBJnacmSXfIG3SnBeX2DSm0jbp39hsncQv/UJ0
	PiGd/UFYlCVvynjuNuLjc2hAdMgJSNphI8sgm8ZFt9BI2IoTzKsRbxL1sEe54uwVH6rNjDA==
X-Gm-Gg: AYBFou38Q2fPo9Hdqo1Od0B/qSXqKiEErXLJt2yWYPJgi4jzywTs2SSJLFRZ5ndDOO4
	G4FxsdZG1v1N+ZpUAIFeZopkOYr+e3UkPDHAbJlo/ff5aKpPPPL/44u6B2XJIrBLKRbxSiqWRJs
	AgbInrLgbBgLgIpXxjSdQdyd8gcCoeXEqBZMCtjTgJqnQk16RYZh4lBfk0QHtMIy5G0f5/2nQ0F
	ogedFwOG/q6LNDC5GLAL0xACebGbALSoYaZDlNoUeTR7xQMUfD16fEqP3IZI4MhRIRPOEC0G3CX
	RGXiLozefav7DTmt8yEKsIWuohvLLBiKTM4HuV76+6W1f2+JB9o2eEM2hpByuyAwpt1LuMSyP6T
	0+fLHlCMvilBmLhVS/HXS2w==
X-Received: by 2002:a05:620a:6410:b0:93f:1fc5:f07b with SMTP id af79cd13be357-93f29c4bde6mr1838302385a.2.1792475571852;
        Mon, 19 Oct 2026 22:52:51 -0700 (PDT)
X-Received: by 2002:a05:620a:6410:b0:93f:1fc5:f07b with SMTP id af79cd13be357-93f29c4bde6mr1838299885a.2.1792475571373;
        Mon, 19 Oct 2026 22:52:51 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1ea1ddsm4705947a12.34.2026.10.19.22.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 22:52:49 -0700 (PDT)
Message-ID: <be1e1980-061e-45dd-8b33-a70709e76677@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 07:52:45 +0200
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
Subject: Re: [PATCH 1/3] soc: qcom: spm: fix the SDM660 silver L2 AVS control
 value
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
 <20261019-fix-qcom-saw-v1-1-9c7ba3fc2493@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261019-fix-qcom-saw-v1-1-9c7ba3fc2493@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAyMyBTYWx0ZWRfXwOyRYHPh8Dw2
 HGbof8AzJAbDg9cbI+MVhgS//TwPzNNndL+XBJ9uTwdj/KL6Rf/EsEKq315Mmgv88dFnNzOT0KQ
 Vcc72tysobU7escODqATeIAzPDP9lCw=
X-Proofpoint-GUID: hunY9apE3KZJWf7fgxvFUX61Lr0BvzUu
X-Proofpoint-ORIG-GUID: hunY9apE3KZJWf7fgxvFUX61Lr0BvzUu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAyMyBTYWx0ZWRfXyEAXxsYCTJGw
 6nVtVhHajd/wZf2RZ0VlNFxjFFYDVbmWJ6bin7qVeIfNAIaImpzh2HTuYwBI7Zk+lW7BDV1qlqa
 X5oqyVvQswyxdMxooE9HDYaIcNwIk9AqWWQzNQXoo9S9WFHRGnkXizUlvgHG7WioImQDZsoUvct
 AINdE91U0iZa/pFVczM3AfmLfr05fbGgC7YCjjKU11RoMjVWqH+APJ5yTiFpPYqb/aRp07quiO3
 f0Rik4LIcGdCPQfM+8U5Str1AUPpqvRX1p0AO33ivLzmpQmB1opHrgoGZS/0Cde4L/qL9ClwSnF
 QoQOt7PM1CNi9HKmnagc2x78w5EOrqgvJuVnaVSXWS9rOHBZJfmQwBTwo7JMSfySHSr2yCbM4b8
 jJAvD4l0/AyqiHM51uhqRs6FJvj7hdnKQ1gsLCEouMyzlqHcsi9csVZODflTma+tiZWBnmYpA7m
 /w4r9JKBYErYW9dCJkg==
X-Authority-Analysis: v=2.4 cv=TcsDJhQh c=1 sm=1 tr=0 ts=6ad701b4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FhHAzHn85Cby55PZOKIA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200023

On 10/19/26 4:39 PM, Dmitry Baryshkov wrote:
> The power cluster L2 SAW of SDM660 is programmed with an AVS control
> value that differs from the one the vendor kernel uses for this SAW
> (0x1010031), so the AVS hardware runs with the wrong configuration.
> 
> Use the vendor value.
> 
> Fixes: 13e72c3e2261 ("soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
