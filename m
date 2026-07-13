Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373DB2FF144
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 03:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783912053; cv=none; b=jxK+3Nw8AozQkg98gKm2dMKWFt7DuvBst5S/hsmWa5673M29sCVK6Inw6tYNK1FIU9+GffLoS3bRiGE+bJ/wzz+wMCVJPpYAyBRXZht5xPRylKLFkJBdF3LPnV1m6ExnPWOZUbZco08ITXKIHQ3GgGoCJxuuqF1ugCwJvhtFPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783912053; c=relaxed/simple;
	bh=DmpDiX22ksbPEucxROJWm5xeUeLy/s/h2aCs1IPYAnM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dgtoaBLHHsxetV9Q9+ZDmgX2Iqz7EtxQcio6sQ5WRoQvcJPslrny5A2DTQbGpw6p2KnvhrXZc0kJ3DVJDbNR0OBGFe0mThxjnAcr9HUiw0ERxbDzp7hywuaDpwxfEizqBJqEJTWxhdQl/vrvvIYh5YQGaIhdH0ROLXbSJ3eBg4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fRsEJX7b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DK2WceZ1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fRsEJX7b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DK2WceZ1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D29Qkp003379
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 03:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OVXyH/TwSzdCUV+a7THlnl3JNi6YLAM042pC5ymDPyM=; b=fRsEJX7bZx4r/kpP
	B62dvhxpExLKtOUpw/96+r8FV7xFcaKFHJUrJ0Mxklu3hOqukq5VhiUujYlsemtg
	d+c0MQUDkgy31tnW1cTarp9jEoyIVA01UXWpqlYugQGXvh2KIf3YM5GiecsI7+LI
	plV5OTmJWiRP1wir3tAzhaGvq4lUnk34/LOAaQdpUBfGuDiJ1AYLBpCMylK1UwhC
	vX2KXZHALhF60BuKeEyIWWNfMDQaS926UXCuI4Z6voPuvU258soonpLaCMv2rIqx
	hgYcFIBhxbPMxc4R8rvrriYw3KNAbxc5/un2irJpufLUqBeSXDzcmCBokp85ju/1
	P6qQVQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe9144wg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 03:07:31 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-848d21bbb55so2540493b3a.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 20:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783912050; x=1784516850; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OVXyH/TwSzdCUV+a7THlnl3JNi6YLAM042pC5ymDPyM=;
        b=DK2WceZ1Zq+de3Lr/axCqjoygQVQD4Fr4pxeZTKkKOwc5fkrwQi5b0+T1zzWRYfX+4
         VuQ3SiDxUX5760Qc9I5p4urkKxZOoPs39YXXfZNZVe/GLUv5+9iVH8KDqYQGidO5FxoK
         V5jBnGD4KkSCZMcRAHFE7sESJN6tRLVsHamWTmpt17hbaGwl6yyXSUtii4s0vXuQQykV
         5zumkEefjiELwE4gB2tOOVmA5h1EUuLVcAOrWOjP2Hoq8cJM4YQej1sfMX8rTnQMxYTQ
         Pkdr6teGCRk+959F3n5NDNeRFt82TEv0QFijmP0QZfgZ/iYJHxQa1tEuDzGtIChxwldw
         BBQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783912050; x=1784516850;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OVXyH/TwSzdCUV+a7THlnl3JNi6YLAM042pC5ymDPyM=;
        b=WKbRngl8OpqAG2tjz92+MEgIrbvONGVIvez3TjyOERE8d8c2d5ZM+OLe1NPFiYfIsJ
         oKLmohdG2n9Uvs9wXUW+glzwarUoiKiN/UKODVpwYyTPbOBWb789SRFThaEaB2fqyorx
         Wa67XsOMmcx7wBv4smMBlsB0Kla+CHRaNcAcOylY+yBbL96seBV+TaJW6MEIBmeMGKOY
         7Hk6tTkX7dX524gf7FoMgh1Rpo4XbhdScw7R7zHjAV9TbFZ/iyBKGJi3sKpTy/jcpYMg
         tMe8te/fQJU+p9P885SIV3+Pzfa7TZpYN7NWXkcgaF8FXRkBjgn4TXsPwwhQD3rc3tjj
         jMig==
X-Forwarded-Encrypted: i=1; AHgh+RpUkjqBKfkr9TW9n19mmzMY19kSUGQ8g9XooYd96tPmyko1nK3SRU3dv4EG1edlqt5yPeGoIr6E9BhDEuvBFg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwvK/n3jeu79Bc3Y0wpCT7dTjEAiyUW9bCXJ0AAj/yJkeMcZctj
	6nQCIRpIJKbiX4h/D2Wbwb+CBfpCDcnWXszeaJi3OLbaNjNG8BdFCKKX8gqALbtp8miXAQ0PBy7
	Zr4f+zm2z4wWRsmRYFi7c1IlhOye7tMm5rLrnb4p0k4rucAh5mrDVgcUOCwdeOdOt5y4WJw==
X-Gm-Gg: AfdE7cnRmvIQhA3i6yUmsBg7UqXHHe4Tc2JSvsqwVFn181kPT18hsliXKn8rWWwlVbe
	gx48+GnzBXBsE1hYohm3YAaUsnJ0LFmSPzBdi9U2nlA7b598z14QcM+EQ2hOUhYjNZEzQEd7mIk
	QXfnWHu9CB/Iq45blKYo0WVX6SaBAi1jfNLoBp37IQQ+cGmgvez5uw27lyjEFm6taomalvjCKCZ
	gTh6iBMCEZFuuAIoPfxEbrBqC/Wpx6FWZ14nLYL1yVwn5FZ9ouTntbKMkMCMkQUpv4EcDzWIRJG
	F8+F9tH7PpJnsVGYovfgo+uUXCE7uVqrZgcF7aZ9c9GSENR8i+4b6adj9OS0lReFsSFnvydgJJ8
	1EHH6UcObN4xnTAmGz9EIaw3xsdKYQSs+mqUP80J2c9fcT/hdVnacdRlgVQ2loSWefNOrYchyQn
	Uq
X-Received: by 2002:a05:6a20:3d8b:b0:3b3:f46:1ef3 with SMTP id adf61e73a8af0-3c110b43746mr9251133637.41.1783912050149;
        Sun, 12 Jul 2026 20:07:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d8b:b0:3b3:f46:1ef3 with SMTP id adf61e73a8af0-3c110b43746mr9251095637.41.1783912049636;
        Sun, 12 Jul 2026 20:07:29 -0700 (PDT)
Received: from [10.133.33.216] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca79aff904dsm5950477a12.6.2026.07.12.20.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 20:07:29 -0700 (PDT)
Message-ID: <03d9499c-4566-423d-9bdc-ef3efd4f0119@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 11:07:24 +0800
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Fix scheduling while atomic in
 coresight_device_release()
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>,
        Leo Yan <leo.yan@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        "moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS"
 <coresight@lists.linaro.org>,
        "moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS"
 <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT"
 <linux-rt-devel@lists.linux.dev>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a545673 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=bKUmyqtfEAg2hwmyn8cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDAyOCBTYWx0ZWRfX+Cz/glCzef5V
 Vt8xuwZrEznnJVlyvclEIniL943Y2Gs0AX1nXQ83MgH+lhrmW9YPNnWzId87BuDy+6DkgJfSYcM
 gdjJ+YzNNEa2TuBUjo+9tE1f37x7gF4=
X-Proofpoint-GUID: X-tCnuSj5-8z7lJ6kul5HAn_Gb-1ubs2
X-Proofpoint-ORIG-GUID: X-tCnuSj5-8z7lJ6kul5HAn_Gb-1ubs2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDAyOCBTYWx0ZWRfX7eorIjvfaW/l
 NQ5Tuen7Hr9fJW+G2bX6MqVFd5HSmcWAipog89vIYiUT0jQR0ZhzJ0hjnX/3a8CTKuP1DFpINmj
 AC6l4SRioPTE1ZPXMbBSTkzUWpJZwSQA87dwNLGO0tECUIS3QgqFAlX7uNSdlF+RGHT7/SD3+ve
 BIGyLB9fBBWPvLVDoCErlfHwGu7oHvPUPs98Fktroh3YZZa5zzmeUhvHHwyA4hryvdgq7Y+pcfJ
 fL7wJmu2bT+H7ISWTvbL+AY61SvOO0jq1Xry+ebxmqjpLfjGQsRe9/cPgxMJhe71NJY/3gcXDg8
 o0tZ9Pt6gACf4VhEKDrHMAQnAwPOg0hrFTjXoxmcl1jkpML8J8OdIQAySGL+tabrBGICXJwzDbn
 OOHfBJfS+1nUb9AfJSeTsz3PA5Pm0xdBRoc15fM3+Kco1dqrmEosu+odO7qgD3kHFuni2MlAUq+
 Xo+xnl79n6gVzzKmRNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-12_08,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130028



On 7/13/2026 5:04 AM, Mohamed Ayman wrote:
> Dropping the last reference to a coresight_device can trigger a kernel
> panic on PREEMPT_RT builds due to a "scheduling while atomic" violation.
> 
> When the CPU enters an idle state, coresight_cpu_pm_notify() is invoked
> with local interrupts disabled (atomic context). This function eventually
> calls coresight_put_percpu_source_ref(), which drops the device reference
> via put_device(). If this is the last reference, it triggers the release
> chain:
> 
>    coresight_cpu_pm_notify() (IRQs off)
>      -> coresight_put_percpu_source_ref()
>        -> put_device()
>          -> coresight_device_release()
>            -> free_percpu()
> 
> On a PREEMPT_RT kernel, free_percpu() acquires pcpu_lock, which is
> implemented as a sleeping rt-mutex. Sleeping while in an atomic context
> causes a system crash.
> 
> Fix this by deferring the teardown of the coresight_device to process
> context. Add a work_struct to `struct coresight_device` and use
> schedule_work() inside coresight_device_release() to safely execute
> free_percpu() and kfree() in a worker thread, away from the atomic PM
> notifier path.
> 
> Additionally, remove the redundant raw_spinlock_irqsave guard in

The code diff doesnt include this description.

> coresight_put_percpu_source_ref(). The lock was originally intended to
> protect the per-CPU pointer table, but dropping a reference does not
> touch this table.
> 
> Signed-off-by: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
> ---
>   drivers/hwtracing/coresight/coresight-core.c | 28 +++++++++++++-------
>   include/linux/coresight.h                    |  2 ++
>   2 files changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 6d65c43d5..9dbdb2977 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -165,13 +165,6 @@ void coresight_put_percpu_source_ref(struct coresight_device *csdev)
>   
>   	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
>   
> -	/*
> -	 * TODO: coresight_device_release() is invoked to release resources when
> -	 * the device's refcount reaches zero. It then calls free_percpu(),
> -	 * which acquires pcpu_lock — a sleepable lock when PREEMPT_RT is
> -	 * enabled. Since the raw spinlock coresight_dev_lock is held, this can
> -	 * lead to a potential "scheduling while atomic" issue.
> -	 */
>   	put_device(&csdev->dev);
>   }
>   
> @@ -1257,13 +1250,30 @@ static void coresight_clear_default_sink(struct coresight_device *csdev)
>   	}
>   }
>   
> +static void coresight_device_release_work(struct work_struct *work)
> +{
> +	struct coresight_device *csdev =
> +		container_of(work, struct coresight_device, free_work);
> +
> +	free_percpu(csdev->perf_sink_id_map.cpu_map);
> +	kfree(csdev);
> +}
> +
>   static void coresight_device_release(struct device *dev)
>   {
>   	struct coresight_device *csdev = to_coresight_device(dev);
>   
>   	fwnode_handle_put(csdev->dev.fwnode);
> -	free_percpu(csdev->perf_sink_id_map.cpu_map);
> -	kfree(csdev);
> +
> +	/*
> +	 * This release callback can run with the last reference dropped
> +	 * from atomic/IRQs-off context (e.g. coresight_put_percpu_source_ref()
> +	 * called from the CPU_PM notifier). free_percpu() takes pcpu_lock,
> +	 * which is a sleeping lock under PREEMPT_RT, so defer the actual
> +	 * teardown to process context.
> +	 */
> +	INIT_WORK(&csdev->free_work, coresight_device_release_work);
> +	schedule_work(&csdev->free_work);

Consider the module unload process, the async work can lead to UAF:
For example:

1. unload ETM4X module:
coresight_unregister() -> device_unregister() -> put_device() -> ref 0
-> coresight_device_release() -> schedule_work(&csdev->free_work)

At this point, the release work is only queued, while the ETM4X module 
unload path proceeds as if the release operation has finished.

2. unload the coresight module without flushing the workqueue
3. A UAF occurs when the pending work is eventually executed and 
attempts to free csdev via coresight_device_release_work(), after the 
relevant code or resources have already been unloaded.

We must drain out the workqueue in coresight_exit to close the gap.

Thanks,
Jie

>   }
>   
>   static int coresight_orphan_match(struct device *dev, void *data)
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index ddf18c970..63253f6c4 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -13,6 +13,7 @@
>   #include <linux/perf_event.h>
>   #include <linux/sched.h>
>   #include <linux/platform_device.h>
> +#include <linux/workqueue.h>
>   
>   /* Peripheral id registers (0xFD0-0xFEC) */
>   #define CORESIGHT_PERIPHIDR4	0xfd0
> @@ -293,6 +294,7 @@ struct coresight_device {
>   	struct csdev_access access;
>   	struct device dev;
>   	struct coresight_path *path;
> +	struct work_struct free_work;
>   	atomic_t mode;
>   	int refcnt;
>   	int cpu;

