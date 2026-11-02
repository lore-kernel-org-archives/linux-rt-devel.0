Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634444;
	b=SoyYEn5j5DekBibBr8OzInr9KUA51KY7KXs3o5W74KeNiC7FkCSV5pimLOQ1rXe+KV4b
	 dwyP9qRCGef+IDgvuBNhRqbPeya1oR8AiHARxS1CsGxxzy1P7J1F/dce+sTUpvJ74FLQQ
	 8uvgvy14lfc/EhI3nsj2h36luZGJpMrKRJI1PEmEIB9ktPcBiSfAa0sRi8YNERq9TzJo7
	 6qBBayeXM4qd8sMI67+s2bSiFeOMqWf6aopq/JSIvHZgVEw08WLlt9O2bUlnRBEexXAP/
	 Fdd0UpOfJNg2N8mIY/ZupcdiDyRcq0at/G8821aRz5Ge28Jb9WyPFSPRBcePUHWe00Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+aPQ/bEuRJE66ZkZ1N1K788ZV0S5XvqiSxNz34MixTk=;
	b=NESp96J5BEzVTUYPVDbQd+Bysa1Phnih5sGV4XcRSAjqGUU/jtDweNpeAT3eu+dzrUge
	 AzWB34ac+KKjXOCXtleCivv7Ty7cKci4vOsaca0qGdwdwl4Hcb+4K9zaI+MR0pxzK1H9m
	 ekcOzLa9Gp0JhOfOeNA8A81YcHyfDDtRgiZ4wWxMsuzu+r5hELFINcaIYYQg1cxEj98vK
	 nTA6gjb1WWYS3zFVvh6Lr4mK3gOn+4zeMdhDFVkIZqrVm09QOhUDyMf0Tx27crR4Ge9dE
	 H1xuDV+aZ9CqyZ+JY7sSwqEmnfR2nTYQ8MqZGHFIzFnroliasSBe+I44gqeN3qQl9+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rC1l5dEa;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7BB606B1D9
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Nov 2026 15:47:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F7BB606B1D9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rC1l5dEa
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a68f888a41so5490325e9.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 02 Nov 2026 07:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793634442; x=1794239242; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+aPQ/bEuRJE66ZkZ1N1K788ZV0S5XvqiSxNz34MixTk=;
        b=rC1l5dEa9QOqo+24JrMwSClwBfBK3zjCDn42COkCD6IaN5VUl3dNiEcWgErwN+Y560
         jwzCYXlxYdkvMvS5EN4fjFBOW64R3uUaXha6A4uDfogZ7S1xHLlfzBOZLZ9lIGKFN9DE
         rtXtz1yHQsIgZZHrjnS19dDMi7H+MaA0qOR2KybuB0pT9SfM0IbuCulAg6MbNBDMCWta
         8r1vh2AvrRxXV/2T342Vmgc1SCIDpto1+wZwyzh0rBrDIcLT4ryWZD1HdVHvyuPz6JE/
         BQG+jOX2aTfyfqptAmamYappdc+kTjPxeb8ybkXB+XHlz/pPSIERtjDtawodqapjsf2N
         9b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634442; x=1794239242;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+aPQ/bEuRJE66ZkZ1N1K788ZV0S5XvqiSxNz34MixTk=;
        b=p5h9v5SW2MECBGxVpQ1B4P12TrdEe/0JfTrEfDdTMeBmTbmVwzNiWYvom2R/aIOpmn
         DUpMD2pNjGp4olDHctnheOd/tEKZQ+gOo1FwU04FdP9Rn0qrvJJk+jzQTgz2QcRu/EPc
         nMkioSaYYTfiRb5iUlZzsT0qZX72D7bWdhXa3fCTQYMKw//2rLu6kDBPCbx9ldz0AUID
         5oHvHam8lc0z+6pvTBSMKTSBalAAm9c7Pg81c2Wp1aqn2AaLCVszi34VKXgcJehkV2/x
         0cC6wYIDH9Ld96omziFoKsMGQ5XQ+bonPJ3jsRXSMIm8OtvxjLZRdU1WoHG/YaLKNb2T
         LBJw==
X-Forwarded-Encrypted: i=1; AKwUvBzpPzrtBFTKgVM70M5IKN4M/3II6lho9Zxqo4T4d/HvPDskf8AHsWHKxgP3gRuCp+syzSkIlZhyvycdQqZtfw==@lists.linux.dev
X-Gm-Message-State: AFq9FYLGHJJmJjDO6yraxIg47KbfSVsQ8xlfiPQhH+D2s8QEkKKFhiZh
	7s0P3bd06mNUcr/6qClG4a0tlLMJBHm3uxeRno8w7xV8yq7FuyGWRygq
X-Gm-Gg: AYBFou2MXh149vaK/Mmroj2/731toaFSlI7rp2743GE1zvVQBh6kpqdjp0GVe8Y76Wv
	LJ2cehq9bFiWtQlwuD8YgqFkNSaCImbZ5PZr586f+kPdOdYQ9x+R3icJJnXhFj1W4mKr89akr0h
	o4F1Yh4OexfbzCA1odyhlKpISbBe9xUzPGD643HLDj0UN16scvSmZP+lLYeMJCFZ0OrDxU6CrU4
	/WNDcLpbznN9qm/u2kPtc79TpYD4c5nXcHMq0OHPOvKaVBjJk15eTxHxsDJTS5on/hE6ppfRJrM
	j61u4rPr3m9tIgtVY6DCaJEGJndqeqmbP/6KGc6AFByPpI5oj4XgDAqyldP9d3JasIHQt2zGQbF
	sSYtgrXGyPFH1Ni20BLWMaNj11LfzUbpSr3cgY6m3UfgBwvOdeD6nQNNrfJqANHL2eIxysvJHwU
	DQfczGAz+iymr5MWAfP1RvldYLksLPBY66WaYwMsneq4176PnsrqJsYp1zUuRc2yV6YCeSNV7SE
	LkKIyzHR1QC5Q/0VGcdNWfry5WOgPBeW1FclkSur964n4XTeX3onrRy2gVRAjls08TcZyZ4FKd1
	8x+T/urnRXeEUnA5/HXYT9qJJabLsx6X3vk2O3um+e4zuOInvDzvZoIwNAdzQVCr/IQmMfHMjKY
	B
X-Received: by 2002:a05:600c:c08c:b0:4a2:1a:a115 with SMTP id 5b1f17b1804b1-4ac1209f120mr204038965e9.0.1793634442375;
        Mon, 02 Nov 2026 07:47:22 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6e63e0esm359259525e9.12.2026.11.02.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:47:21 -0800 (PST)
Date: Mon, 2 Nov 2026 18:47:17 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, Hui Su <sh_def@163.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix cpuset_mutex double unlock in
 __sched_setscheduler()
Message-ID: <auimbkttN-iPGtwZ@scheduler.schedules>
References: <20261102134606.242743-1-parri.andrea@gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261102134606.242743-1-parri.andrea@gmail.com>

On Mon, Nov 02, 2026 at 02:46:05PM +0100, Andrea Parri wrote:
:
> A sched_setattr() with SCHED_FLAG_KEEP_POLICY on a SCHED_DEADLINE task
> unlocks cpuset_mutex twice if the task's policy changes concurrently:

Uh-oh.

>  kernel/sched/syscalls.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
> index 45a127deeadd9..2af550f92ac65 100644
> --- a/kernel/sched/syscalls.c
> +++ b/kernel/sched/syscalls.c
> @@ -640,8 +640,10 @@ int __sched_setscheduler(struct task_struct *p,
>  	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
>  		policy = oldpolicy = -1;
>  		task_rq_unlock(rq, p, &rf);
> -		if (cpuset_locked)
> +		if (cpuset_locked) {
>  			cpuset_unlock();
> +			cpuset_locked = false;
> +		}
>  		goto recheck;
>  	}
>  
> -- 
> 2.53.0
> 

So the issue is that when tasks policy changes before we come to this
check, we don't clear cpuset_locked while calling cpuset_unlock().

In the other calls of cpuset_unlock() this is not a problem since we
just return and don't use the local cpuset_locked. But on this one we
do. And if we don't retake the lock it just stays true. Even if we
didn't claimed the lock. And that causes bad, bad, bad, bad problems.

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>


Thanks,

Kayra

