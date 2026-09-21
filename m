Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB4345EAD
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 07:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976835; cv=none; b=Kx7vZqmJ8R7rBmbcBqmpWcy3gBD5u2aBpyE0vDcgdqaPN2FJtPJmY+OWQVgzRGJNcLb1g85FlgG3iAjZjhMQZjh07hTtQTYP4IUaERIdXQpDTYw4GkU5GThAFtbAejl31xDaeZbOR39QxkW3dGn9DLeo/5jpryjgUvlxwud5T00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976835; c=relaxed/simple;
	bh=uHqzEv3bxIoes2LtlPov0BRmSAZOsCBWSajsNKxiV1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/awxCybqWanpTDRdVz+QLaBZUjdpxNgZ8Foe/P6gKxKOukAKlqwLCB7vKkWhfaGjUyNHCEdaAdrg4gjsCI7gm/vacCiMCg9f9hAf5UKq6doj6NoBZOwk6hrpdu4Swz/A5UBZo4aj1RTsPqK7vyR9rYthlH81UEUdxphF2CiHmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UA0o/9zZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Eoy6PZZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UA0o/9zZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eoy6PZZD"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7A4bl467404
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 07:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gUu4bEc3zeYui4hd3ktvRDKKi+11f2S8vhCkBPJg2go=; b=UA0o/9zZBA88HlBd
	W4hiEnubln+RVKIrC8iim/G+mK9eUvVH5J/D/ZBx20NSuM0S5aoPeUpxzT//oWEQ
	2xVGC6REZnN29C9Gmex+ttlwkfjYkEzps/LTR3hT6QASlgGAzqH2ZQlPZQqe4MAF
	2j/ypFkTm5WK5MfvTg0cbn22QFxUGn/P8Bt20SF+Yzao9qrVoNNqUem1tGcFPz5Y
	SztqCXex+ruMK642k6XCGun0fhirhGyPG1to7jhVsNFJv+7ion4Tz0m5DBllvwan
	/XN9OLQZHfexRmxzXYla/TON/KzVgGjR+IelHeJd+zpR3WjsCPIr9GR6xUu7Q6JE
	Xn6P7A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtq8b9gnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 07:47:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d6fed0652bso32047255ad.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789976832; x=1790581632; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gUu4bEc3zeYui4hd3ktvRDKKi+11f2S8vhCkBPJg2go=;
        b=Eoy6PZZD/Lnl3snTjkfYEjMW1jphoZSMdx1euyzu6WlCwrJ4KPlw2I/FvxTI4VCSyy
         MoS6JLzs5wLa3q/SjMYULOzCIoUglgvck6GE5yJBS2LKiIlHXJxuBSR6uCkvtzdtW3hS
         FQQPievkMcYC4/fo9g8ie1xLZVU5iy0u6Uv6tImV8JKsIVMHY19qkhC4mBhmr4DlbGzg
         ks2ijfr9Nm0TONdlZQHo/BhOIlDQraAibxVm3BshqKMdBa5f14mcqWvDtXYJZrbyZ2hb
         ap8nLPw1NHKtxw8v5Zi441tEz1YgS43TJIA8g72qgXGYZpNaNUeaDYwy4tNH87Mtiupi
         lRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976832; x=1790581632;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gUu4bEc3zeYui4hd3ktvRDKKi+11f2S8vhCkBPJg2go=;
        b=PwLkz7T7+YoAGbktlfr6RKiRTqf372WkjpA6pin7JmygDT6aGdOPVjENzDjbkAPAj5
         8DY7KwCi1Veda3WWmD4YI8Wu0kcRJUeCOu4L+4zIHfY6Mb6CRIN2wJTzhvPi0J7dillr
         lu413GskhhFZcxAB7Et50R4UCXarGAWCFYLmOhKTrXu4ewJ+spg/ctHtSlWiB7p5z7LO
         gqRJg4tT7r62W27b9eb+qk2YztwfVKDEk13IE7eJ8b4uZ7+lDJXgnKGr23iRmyRIYkDx
         l27eq2E7wUYyP/UG/ut1tYOoRWV7amYnm2oQ64yRpKneEiLYW2ljLsfmeWafCR/+Z++r
         tTHQ==
X-Forwarded-Encrypted: i=1; AKwUvBymVL+/f0SlucpzUHyElYKFfqN4qs9Y6Z6Zw/7OxNm/CMpILrkKCGNkVvnKBVvFTjXAHWRoqNbjOtm9HDvLOA==@lists.linux.dev
X-Gm-Message-State: AFuF++lFnyrNTDt8sto6CfWVGB6yqVNUzh2VIWYOquB++3CAUhim4g9Z
	mRFgjsle/A5fJlXb8nqCNOBbukamOkr3UaFVF0AT2xYQAuG7yJ3H3Yqi4Alx3oXhT8ypxaFVWDY
	hFLhJJMoMyMg5y68AN9oCYvYuAAHJZ5BoUeH6NlOg73BU9jWh23k6t/hDCmTQ3u+7UN8gTA==
X-Gm-Gg: AYBFou3ADvsT+c7+rKMMUcWm9HV9gOdedbvaRoTEzLZQ4jZcSRl3hj/UfOe5wqr6y6I
	Gh8ERzIRszjTUDG1aV8plm+1KNa1uz73S8bx1OwmCeNJ5t02vW/9F79vL8N8vpDAwQAK6HdJtEY
	nzhCWqPxDh4OD9hMrjmaR15Y0EwG6pT8TG6XcXnCFPCtyBDKDGZCFc4rr9tU2m0JcBRhzzsNkIn
	bdcK3Ss5JeMvnP6z8wfWJ5vpjBm2sjJ3kqGqrTd3Wd+EYLYLaGoMkhAbhLLsMi8RwKu6E+osAzt
	FBSBuep0WEqd44RO9NnLrzm01zuye4yqiv9Ds7EJ0f/tKt5Zdpth68dbMrcaoDlQ4l02LFUlcgd
	cdY3MMF0g5wE2V7sUij3K1damuVU+
X-Received: by 2002:a17:903:298e:b0:2dd:c100:80c1 with SMTP id d9443c01a7336-2ddc10081dcmr89823255ad.60.1789976831686;
        Mon, 21 Sep 2026 00:47:11 -0700 (PDT)
X-Received: by 2002:a17:903:298e:b0:2dd:c100:80c1 with SMTP id d9443c01a7336-2ddc10081dcmr89823025ad.60.1789976831226;
        Mon, 21 Sep 2026 00:47:11 -0700 (PDT)
Received: from [10.239.132.187] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc179e248sm29105175ad.36.2026.09.21.00.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 00:47:10 -0700 (PDT)
Message-ID: <f8e91551-64d8-4cad-9757-f461fb13fb7c@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 15:47:07 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
To: Tejun Heo <tj@kernel.org>,
        Fredrik Boettger Bratberg <fredrik.b.bratberg@gmail.com>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev,
        sched-ext@lists.linux.dev, aiqun.yu@oss.qualcomm.com
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
 <ad539mUd8A0lDWAw@slm.duckdns.org>
Content-Language: en-US
From: Tengfei Fan <tengfei.fan@oss.qualcomm.com>
In-Reply-To: <ad539mUd8A0lDWAw@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDExMCBTYWx0ZWRfXxnoFXQweCZu+
 Mevv8e1DMaB5BBt0Vai30Fz2eHJlmhh7K36uHTWRGBercpkgDBM8Q5YM7b90V7vtsZ7qL+bi/l1
 L33yGcmsuljDp7W6zTDPX5EcfgxuBe5Xv5km6n9nemM9k/1RyV4Dk/r+wLukr6c0gJbVkgQCr3a
 oXZCyHFtv2TIyooSYjZ5JPwasjzgi1XkbJ4uDJ8ruDD+v36SqR1sNq085I4+01BmZnUcy9/KfH3
 qlhLoDstGOH0c3LH09PnsFdZR5ONmdy+zqKyHf0ZwsAr0D3ax/6pApA5D7inaxW11udycU1Gv3G
 F7RDxyqXvXze6qVJhxslRIdJmiv2qnM2QO5X0aFKSH6XXUlUykTAgbHP4FdAoa+JFfcUOdfNmIY
 lJI4uCQd28xNyCQOPBqeRt8sqeYaJgwQDejlMPm05iR5IC6QDOaX/k4MlpyWi3LSUANAslNQKnS
 3fAq8CFy38wBkCyfxbg==
X-Proofpoint-GUID: DQPU5n8Vz1ApBqmTWMnee2y9eLrLSdf0
X-Authority-Analysis: v=2.4 cv=T/8Z3PKQ c=1 sm=1 tr=0 ts=6ab0e100 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=8ueUhNlu720Qx81Ww3kA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: DQPU5n8Vz1ApBqmTWMnee2y9eLrLSdf0
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDExMCBTYWx0ZWRfX+/NXi9vHaWyW
 MqrlnGhTHOLMQt2EgAWRwwBQxYVwp16utTlVGHAAkVXWu49vSH9p1Lt25RHOkHY/ajoFSd4PVd4
 GLS93Zr9dlXJWO9BFw0YagMFsDk5XgQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 clxscore=1011 malwarescore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210110


On 4/15/2026 1:23 AM, Tejun Heo wrote:
> Hello,
>
> On Tue, Apr 14, 2026 at 02:59:33PM +0200, Fredrik Boettger Bratberg wrote:
>> A recent paper published in the 2025 Real-Time Systems Symposium (RTSS)
>> "Enabling Flexible Scheduling in ROS 2", would presumably also benefint
>> from this feature. The paper aims to address and improve the real-time
>> capabilities of Robot Operating System 2 (ROS2). As part of their paper
>> they implement an EDF using sched_ext. They do not explicitly address the
>> issue of their EDF SCHED_EXT tasks effectively having a lower priority than
>> SCHED_NORMAL, but it is a known limitation of the current sched_ext class
>> placement
> Isn't that mostly solvable by just not putting tasks in DL/RT and enabling
> switching_all?

Sched_ext is an enhancement mechanism rather than a replacement for RT 
scheduling. RT scheduling continues to provide the latency guarantees, 
safety properties, and forward-progress guarantees required by the 
system. Additionally, the system must remain fully functional if 
sched_ext exits and falls back to the in-kernel scheduler. As a result, 
in real-world systems, assuming that RT workloads can simply be 
eliminated is often not practical.
>
>> This change conditionally reorders sched_class selection such that, when
>> enabled:
>>
>>    STOP > DL > EXT > RT > FAIR > IDLE
> The problem is that RT being above EXT is required for safety as EXT depends
> on RT superceding it for enable/disable path forward progress guarantee. If
> you put EXT on top of RT, it's relatively easy to stall out the whole system
> without any way to recover it.

Rather than requiring all RT tasks to be isolated from sched_ext, it may
be beneficial to distinguish between recovery-critical RT tasks and
non-critical RT tasks. Recovery-critical RT tasks would remain outside
sched_ext control to guarantee safety and recoverability, while
non-critical RT tasks could optionally be handed over to sched_ext.

This would provide a balance between robustness and flexibility. In
practice, many RT tasks, particularly those with lower priorities, are
used to satisfy latency requirements while still being tightly coupled
with the scheduling behavior of other workloads. Allowing sched_ext to
coordinate these tasks may result in better overall scheduling outcomes
and workload-aware optimizations.

>
> Thanks.
>
