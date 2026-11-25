Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602995;
	b=IXBKxm3TkftIxxx+yn2QJpOWlWLZT3N45kFbPhVd9a+4Il+H648jY3tqOIUJ5FNjHfWm
	 vjFYImNJNMaEm6Fe+FSSVRo9Q7dygfOiZDCZSBzIKlIedI+6px48VwARs0S9ale0ncOUR
	 6C1+j6A5+2x5Shv2PC3C5i81mYDp9DefDPRBtDbb1O9ugxy9q0A8mrF1wpHYnclWZhOqw
	 pdJ89gN0Kx7pd5t+LyeqZX1P0NBTvDB6+o1xBqJMaQPqQAtx12NhvAQz5KHr+XN0MhL2J
	 ZQdkuLj6Yi/I6rEYcYRpTXrwu2biLtTGEn5TpccTnioy8SlSgp3pTcGs2E+lvoEe0iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602995;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=;
	b=HIpwOInpz6qif9ssKQKXfulaySXFV3zrm5h4wiR1aLhkYdJpybxCxPqJKPF9BEg/A58q
	 +cTo98rMmxNmYQetNBsXocrzhwu0Ac6+icK2DX4a9tBWA3x0uWFNps7h+LINh+oE84/Ck
	 3PlOY8G9TAtiBOskk3anuWodWEo/XuAcQSajKu3gCf7VIAHcI8pcYMqpGmM2VHLeTz6Xi
	 Gm0SFF8gYnCUdanraAbHe2jx4akj9/FpLRKui8P9fZYBGPTbn4DfD2mydAodbuue/okur
	 wj1gOof9w37Fyi8ITp/kXZZUCWYlvoSxZe2TNMg2gqTw+BaUxxX4+fpG5ZjTywubGhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4YwkgWa;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AOw5Hk4S;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA85606A326
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 10:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AA85606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b4YwkgWa;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AOw5Hk4S
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mALg115101
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 10:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=; b=b4YwkgWaX5Fozf/d
	FCcmChtVMCETvVXv2M9im1Hzn8szRM/kXz9Ix7ZfMKLZE9DCjJFfoMQL5F3JhMho
	17J9SWHDJIlozED9HRjUZmwv0le/Pf+Lrm1KhqeIeNNqGnXBDO0YhvE+RUufkH1s
	9DdsprT4+SEMKzDqkTI2CGWOPfSn+3xTONAyBbL2x0EwJwyLve7/es3WDfkXBfzn
	zEnyk0S0sAwrRszZ4i/XLq0+xaSgMuj+58WavUmo9c76SPmu6Nqw35p9EyEGu/L5
	javuNWbMtR+J5x1elMlrx+5pJJzsYR+6l5Ahlk56T6PVKgZKySLH6rFpXi7KEOE9
	Fptcmw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5cxkcd5w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 10:36:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b41e8c1ac0so8146014a91.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 02:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795602993; x=1796207793; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=;
        b=AOw5Hk4SS2qd6WNEWwwS6xjjtGeqaih9lhN54mPJAGowOeu7355JdGFBDpzoSiPH17
         kAIXc2wQtfgwnLgPeuQWLoBuhn5WVdEect40MNpDtX5DlZjn01LhXifTW2oVU4Ly0si+
         TzOzeDdCy1dGs/ehL7l/vix9dPvUlYT2xUuXVshLslGgRA8kw4OAo0uRkbn41otaFHzi
         Jmt9bwdGNaP3K47Nv5WzxdNmkDLKCqSsHqQ8yyI4J9YWMpxrRXDgEC0q3+adgF264XlP
         CrQLV9l28Clvk/wGs/rNGm17yLtyqUC2Hu05tfDIuW+SjiUlxbbBtuQBijlaqxD9Vc2R
         MryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795602993; x=1796207793;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jAEsJZYaibUUOKZ4k7NMqSX3DBwN04ZW3KixEdHDmuI=;
        b=mJWspgEvHZGkqe2uItwJUrYTIl0ixgFFGoit7/yPsT2M7nHDdH2zMYb7X2TPSopXjz
         lTNhk5EpuC9MVvcHaGxHzjP1Ivk01zazXeS0202U7x7ncbDYEWvbi8z01rPk/92N21bO
         ciOLOJQfC0/MsQZyhj1pGf9c2W5sh4JH82Ehbbs26aKrMPlfdwMXoJMjyHTg5M5cUMjh
         Prv+rS0nfA2fZawTQjj0Knxjm09IBP7v8SQl2Xmx7qBVE5Nw8EoZvPSsliwPNxVhJ4wR
         c5KgrpBV9hit0m2Z3OuvAzlR01+dRVLn4T5kofK+c2m5x7hsD7SVrZbSOlTL5FZvRVqy
         P/6w==
X-Forwarded-Encrypted: i=1; AL+hErHMB9s4eW3JqGX0O+ApNLyEX97bVgyshm7WmAVDBYiEFRgIfKRSZq+p2VH2rYVTF6NIwa1CmxaQ+f1subf6/A==@lists.linux.dev
X-Gm-Message-State: APuU4Z+JkREG5HEzgbhMP/n7audwwbKoeKVjgXhpWBSVq2idemakqRpL
	sdnRmaOsatZujq2wRXj9BxFl0P8tQoQ2NiS05ojJi++jThvFL36KLuttsH8t7SnpX+W/T7RdIHs
	7XmvyO4GqTCVcCMKyFj6jJUKl/3S+wlHffhbgWVfHSY/elMklHtPh7g0y8tyyGSsx+M/Dyg==
X-Gm-Gg: AZFdTZeyGdLNcNcMOgugG5mSovFG5cq9IRUfsXPFZkS0IbY5fP4uzSMxg73WHk9X/XX
	Ho9GKLpyNWEvtRrE4fAS1M7dJx9p+aUzIm5HKCvsvDCPLAAnFUBuLS0teJ/+8Kdnnc2mvohzV9G
	hQS2EEIaAUH+9QIzpCDRpElJ9R1E6Tk6DRYTijC0xrUCYCdhMW97JBScShB0YW8mGmpD8fiuQze
	BDIyaxLZqv9GGXLwB22vWGvIOWbmXWv8ej+V2r2wVSV3IaUueulNNZrqZEjuRI1mdmsdjj7Nyom
	k6VEbS/Qd4DjYeyBejKoL2RpkavHOF5Eh3Jj+B8w20Ioffg5st9/bo8ruIfDY4+aaZwpuEdgXld
	Gz1YL4I3hd/ucZttFRBGkTbvqEB/9l92xhxtbRPMiMz+x7aozyaO43BTSmA96AAI77KcuUnM4Hl
	ubTeI=
X-Received: by 2002:a17:90b:4983:b0:3b4:ba6:f712 with SMTP id 98e67ed59e1d1-3b41c9988f1mr18869675a91.60.1795602993128;
        Wed, 25 Nov 2026 02:36:33 -0800 (PST)
X-Received: by 2002:a17:90b:4983:b0:3b4:ba6:f712 with SMTP id 98e67ed59e1d1-3b41c9988f1mr18869644a91.60.1795602992591;
        Wed, 25 Nov 2026 02:36:32 -0800 (PST)
Received: from [10.239.133.197] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b82e624sm11657648a91.4.2026.11.25.02.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 02:36:31 -0800 (PST)
Message-ID: <42b78eda-ea3c-46fd-bab5-ceb81e22f720@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 18:36:24 +0800
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
Subject: Re: [PATCH] cpufreq: schedutil: Run irq_work in hardirq context on
 PREEMPT_RT
To: Christian Loehle <christian.loehle@arm.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
        bigeasy@linutronix.de, clrkwllms@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev,
        Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
References: <20261125080613.1138573-1-zhongqiu.han@oss.qualcomm.com>
 <86b5a9f8-70f3-4a5f-b023-c9fb1a2faf83@arm.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <86b5a9f8-70f3-4a5f-b023-c9fb1a2faf83@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX5KCboG1m01dk
 uzWOBFiK3ZypZGJVCdfy7wrv6bB3l4j3XODf40AvDcv2Ff63OJ2rfQ4+6uyO6SEU6hMjVh/Tb5i
 bt5fkX1afYqxjCzloRg0JR3A+lZTMyWh17p3E5/lXKzMLh7Jyw+D4mguMBqi4ce7Qv8SZNRWcDj
 Lga/Lk2T1OyYrp5eocuo8EGxzmZ0nSiEYmJ/F9TdXS44Rx35AqvvpDc7ydaVLvJCjPfYDYWbkPb
 aqwsqt1vaGTyTbA+jtDii85p4Czs9j2U8+2lVbaUNNISiofSnLeF6Nd0HETmU7OdrwjlNqp7pKZ
 xQXlzNfLyoNTA9Q2WxLW9wjWsL1kmlqbsLjkjD0vj3Ux0jMhn9oDLtSoamhnz3mtLGUhsobRQig
 VfiDWhOl6FUSL6+lR8jJYS8JS7CNSsG/+3u+0XDFAXwq9/vVJ7qAhrhllc7b2VTV3M20cpzQl02
 xL8YjyKimgzOOcmxBjQ==
X-Proofpoint-GUID: JjdUhZ8LWidEVKp5lVG1t3ki1z3oXFEE
X-Proofpoint-ORIG-GUID: JjdUhZ8LWidEVKp5lVG1t3ki1z3oXFEE
X-Authority-Analysis: v=2.4 cv=TLbQ2Fla c=1 sm=1 tr=0 ts=6b06ba31 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=7CQSdrXTAAAA:8 a=YpS8oBoqdfD21wqEnNUA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MiBTYWx0ZWRfX+oUq8ZJV+oN+
 UHES/T/99gK3ccDqmJStQLNvigQH2xuk08+y+QP7jAaDzaTjEc2yE1qkwv/sTHnGwOsDPRN/gng
 4UxNbK4opEFPhYeNJKrBq7AytJwgDeM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250042

On 11/25/2026 4:26 PM, Christian Loehle wrote:
> On 11/25/26 08:06, Zhongqiu Han wrote:
>> On PREEMPT_RT, an irq_work not marked IRQ_WORK_HARD_IRQ runs in the
>> per-CPU irq_work/N thread at SCHED_FIFO priority 1. The schedutil slow
>> path queues its irq_work on the local CPU, so the wakeup of the
>> SCHED_DEADLINE sugov thread is delayed until no other RT or DL task is
>> runnable on that CPU.
>>
>> Meanwhile work_in_progress stays set, so no new frequency update is
>> queued for any CPU of the policy: one busy RT task can freeze the
>> frequency of its whole policy.
>>
>> sugov_irq_work() only calls kthread_queue_work(), which only takes raw
>> spinlocks and is safe in hard interrupt context on PREEMPT_RT, so mark
>> the irq_work IRQ_WORK_HARD_IRQ, as commit f8d958880933 ("srcu: Use
>> IRQ_WORK_INIT_HARD for srcu's irq_work") did for srcu.
>>
>> Tested on a Qualcomm SM8850 board running PREEMPT_RT, with SCMI cpufreq
>> forced into the slow path. With a SCHED_FIFO 10 stress-ng worker on CPU1
>> (30% load, 50 ms slices, 15 runs of 5 s each), sugov_irq_work() now runs
>> within 15 us of irq_work_queue() instead of waiting for the RT burst to
>> end (up to 212 ms), and the policy frequency is no longer frozen. The
>> irq_work latency below is measured from irq_work_queue() to the entry of
>> sugov_irq_work(). The cost is that the kthread wakeup now runs in the
>> irq_work IPI handler, as it does on !PREEMPT_RT. In a separate cpufreq
>> stress test with cyclictest (SCHED_FIFO 90) on all CPUs, this raises the
>> average IRQ work IPI time from ~0.5 us to ~1.3 us, with no change in the
>> number of IPIs, and the cyclictest per-CPU worst case by ~2 us.
>>
>>    PREEMPT_RT                           before              after
>>    ---------------------------------    -------------       ----------
>>    irq_work latency on CPU1, max        130 - 212 ms        <= 14.5 us
>>    policy0 frozen, total per 5 s run    0.57 - 1.25 s       none
>>    cyclictest max, CPU1-5               13 - 16 us          14 - 18 us
>>
>> On !PREEMPT_RT, cyclictest and IRQ work IPI duration are unchanged. No
>> lockdep or DEBUG_ATOMIC_SLEEP splat on either PREEMPT_RT or !PREEMPT_RT.
>>
>> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> 
> Missing a fixes tag then?
> FWIW
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks Christian, add the tag on V2:

https://lore.kernel.org/all/20261125103451.1385246-1-zhongqiu.han@oss.qualcomm.com/


> 
>> ---
>>   kernel/sched/cpufreq_schedutil.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
>> index 14405a614991..b2e9ac7e3517 100644
>> --- a/kernel/sched/cpufreq_schedutil.c
>> +++ b/kernel/sched/cpufreq_schedutil.c
>> @@ -726,7 +726,7 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
>>   	else
>>   		kthread_bind_mask(thread, policy->related_cpus);
>>   
>> -	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
>> +	sg_policy->irq_work = IRQ_WORK_INIT_HARD(sugov_irq_work);
>>   	mutex_init(&sg_policy->work_lock);
>>   
>>   	wake_up_process(thread);
> 


-- 
Thx and BRs,
Zhongqiu Han
