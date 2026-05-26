Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200A138C42F
	for <linux-rt-devel@lists.linux.dev>; Tue, 26 May 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779817833; cv=none; b=Tu62TPvuLBVIaDEm3BTpmcWLFFXq8ZtaVbECq4jpnlCeYW2AcCw4gVbv4rPhxWEDQVMyr0PY0iYyYud0wdeCCde6VyibkhrgidHUUV/ReA/sRq+1krhfwVZnH/pu7FxvF64UacLACqivRAhNkHb9mrkRF1HOeYOj6Yjrv//9/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779817833; c=relaxed/simple;
	bh=VELPm7/dG8t0d/Byl9ml2ENw26WogQUj8jXnZDu+wwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqpoaBXleyEOgdxW5OiMe66D3leCQHqW5ZhOtFs7uWxG91agbEMXRMTomRz9NXPTd6FOjl/wDV/1T5wa4YTjzulWx5w/v3s6YCt34DuyqQKNutFoVh4rNOla9YIiTZQKao0WYOzNojs2dXQLP1TSP9j6DC7iKAX9EV4DEyzZBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=ERbQtstK; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="ERbQtstK"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-30246cfd41aso88808eec.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 26 May 2026 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1779817831; x=1780422631; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXpTxnedlsoWMNq1PmG/QEE6cY91+9WqD8u42rEyTwQ=;
        b=ERbQtstK/qmWjx0r1L0uP9+FJ4nXbxcpNXqc/RR6od6caagcRtvPg0mFieYPcgag/5
         KO+r7vtImgctFK7Lo/6jFhmIgftDdM3xRs1dVC08VKrNxhGFTZBhohaPFsxKFTIG4Fu1
         10SLPEyU7mEHvm8hPPkGXavR6tdExnW5MHc9H7SpSnjtvukmn6IWwMDfunwQUTVdudQD
         mf9czXVGEiEiD33E7GyQ3d2atSsoNKh0kXfLNyI5MFfP4/avSnCsplM3frIkr5P9ycUV
         NpFgCKkh6NjlxnueN62l2mHwg3Ne1uMPX76pSkQozgekbhhdAv2LZPRUXBOJPu0ofc/3
         aObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779817831; x=1780422631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXpTxnedlsoWMNq1PmG/QEE6cY91+9WqD8u42rEyTwQ=;
        b=OY5PxJq09dbBpizPx6wLUD5i0Fs/xu3DIQFR6ZITiiyYhms8ttEy1QiOcx1xvaWm5I
         52yyuG2EkoJ1q2X4ka46yT/NL57A/SLbzPeTat3TZBuDa2yFugI1gdjgE9m1IvdR80/r
         21WK0cknZ7zk1vgITDX0BM7ax55eDtQd2BZlRQP9jimcqCP1N7SjoITMG6uS+4ShAmYx
         SKYNudH1RLeyObu76LYzZeA8vxp6Ya0NLXrqc3pWrUhg3HphiNV5q0gx3j5+fwbesj0J
         Bh8rVWhbTZtf3nTZTaNteG8Tbxt9wVBQi3MhCZ9Cnwh2U//JPB3EXJhSaAM2WJmpKNm5
         /cCw==
X-Forwarded-Encrypted: i=1; AFNElJ82w5YrxxkCwi/n3SDvrKm8ZRAARgCRVM+sMlZNfj8OTd8hpAYI8g4eLTGH82vZLArpuJAS8VNUL8gALtkREw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywa9T9hZFP2OIpiDLk9BVeEQ1KdvlVaPxzwDPnPY4XzCBQPl8dh
	Q6dTMqNXHRP7iCXUErKF4WFL027Vm7+AxHL1lC831jACL5atdAB7mu2O1WBfN9SnQ5I=
X-Gm-Gg: Acq92OGocpCS1oX3Tpp/bI3X6Wuge+YMy4CgyCtKxonPK0OMCHfdbuetF6gXYjETtXr
	KoAkuzRHFrdQ5a/dnVhFcj06+i1/l3jL0KWtPjGQSrTyPYWq2xswfauZMW0yO33leN5s783dsES
	Dh7r83pSClHheT6Da16BbXP3UjGBnnRAIxK+imPpeACxo/txDldglSA0SyIKel0GTOMgDcinDGI
	qrhGak8gej3FO8txXi+kviFakZAVLdl7PTGmhIIny55s7ywnagtW43c1qyqPk2L62aFgClfZVAb
	eXXLnVEuTJzqa8hyTQ/jRiaBxzV6Bv2AlDP3P33Y2JclPBlRH3IRDBMpCR6VkwpWrS8oWC4ogGM
	HkaAOJVNgE+anrNlLtAy3mcwoBa4xhO/MRMwuuxfKDMsdPgzc20rk/0jKCOaQ9HlhlZoNJV3cHv
	34uw4AusCwaE3g4j9W0HwNgF1gohfV9fxFN7Dw
X-Received: by 2002:a05:7300:509:b0:304:6782:d5a4 with SMTP id 5a478bee46e88-3046782e5edmr7324460eec.5.1779817831126;
        Tue, 26 May 2026 10:50:31 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:f31d:7c8e:ac22:8eab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f1fd1csm10879907eec.8.2026.05.26.10.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 10:50:30 -0700 (PDT)
Date: Tue, 26 May 2026 10:50:28 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: Rodolfo Giometti <giometti@enneenne.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Byczkowski <by@by-online.de>,
	Eliav Farber <farbere@amazon.com>, linux-rt-devel@lists.linux.dev,
	David Laight <david.laight.linux@gmail.com>
Subject: Re: [PATCH v6 3/3] pps: convert pps_device.lock to raw_spinlock_t
Message-ID: <ahXdZFrw79US8MO3@mozart.vkv.me>
References: <cover.1779733602.git.calvin@wbinvd.org>
 <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3fa6ae908b37681ec6857b413179b67a7655c753.1779733602.git.calvin@wbinvd.org>

On Monday 05/25 at 12:49 -0700, Calvin Owens wrote:
> From: Michael Byczkowski <by@by-online.de>
> 
> pps_device.lock is acquired from the PPS hardirq path
> (pps_event() and friends). On PREEMPT_RT, spinlock_t becomes a
> sleeping rt_mutex, so taking it in hardirq context produces
> "BUG: scheduling while atomic" splats and breaks PPS event
> delivery entirely.
> 
> Convert pps_device.lock to raw_spinlock_t, which remains a true
> spinning lock on RT, and update all call sites in kapi.c and
> pps.c to use raw_spin_lock_irqsave() / raw_spin_unlock_irqrestore()
> (and the _irq variants where appropriate). The critical sections
> are short and deterministic, so raw_spinlock_t semantics are
> appropriate.
> 
> No functional change on non-RT kernels.
> 
> Tested-by: Michael Byczkowski <by@by-online.de>
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> Signed-off-by: Michael Byczkowski <by@by-online.de>
> Tested-by: Calvin Owens <calvin@wbinvd.org>
> Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> ---
>  drivers/pps/kapi.c         |  6 +++---
>  drivers/pps/pps.c          | 16 ++++++++--------
>  include/linux/pps_kernel.h |  2 +-
>  3 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
> index 1bf0335a1b41..dc7fac75ec27 100644
> --- a/drivers/pps/kapi.c
> +++ b/drivers/pps/kapi.c
> @@ -102,7 +102,7 @@ struct pps_device *pps_register_source(struct pps_source_info *info,
>  		pps->info.echo = pps_echo_client_default;
>  
>  	init_waitqueue_head(&pps->queue);
> -	spin_lock_init(&pps->lock);
> +	raw_spin_lock_init(&pps->lock);
>  
>  	/* Create the char device */
>  	err = pps_register_cdev(pps);
> @@ -167,7 +167,7 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>  
>  	timespec_to_pps_ktime(&ts_real, ts->ts_real);
>  
> -	spin_lock_irqsave(&pps->lock, flags);
> +	raw_spin_lock_irqsave(&pps->lock, flags);
>  
>  	/* Must call the echo function? */
>  	if ((pps->params.mode & (PPS_ECHOASSERT | PPS_ECHOCLEAR)))
> @@ -214,6 +214,6 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
>  		kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
>  	}
>  
> -	spin_unlock_irqrestore(&pps->lock, flags);
> +	raw_spin_unlock_irqrestore(&pps->lock, flags);
>  }
>  EXPORT_SYMBOL(pps_event);

The Sashiko LLM says:

    Both wake_up_interruptible_all() and kill_fasync() internally take
    standard spinlocks and rwlocks, which map to sleepable rt_mutexes on
    PREEMPT_RT.

It does seem to be correct, with CONFIG_DEBUG_ATOMIC_SLEEP I get:

    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
    in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 31, name: ktimers/1
    preempt_count: 1, expected: 0
    RCU nest depth: 2, expected: 2
    CPU: 1 UID: 0 PID: 31 Comm: ktimers/1 Not tainted 7.1.0-rc5-00004-g85f7c8ee247a-dirty #3 PREEMPT_{RT,LAZY}
    Hardware name: Raspberry Pi 4 Model B Rev 1.5 (DT)
    Call trace:
     show_stack+0x1c/0x38 (C)
     dump_stack_lvl+0x58/0x78
     dump_stack+0x14/0x1c
     __might_resched+0x128/0x168
     rt_spin_lock+0x34/0x180
     __wake_up+0x2c/0x70
     pps_event+0xdc/0x2b0
     pps_ktimer_event+0x44/0x80
     call_timer_fn+0x34/0x2d0
     expire_timers+0xcc/0x228
     __run_timer_base.part.0+0x18c/0x1a0
     timer_expire_remote+0x40/0x58
     tmigr_handle_remote_cpu+0xb4/0x278
     tmigr_handle_remote_up+0xdc/0x270
     __walk_groups_from+0x3c/0x98
     tmigr_handle_remote+0x8c/0xc0
     run_timer_softirq+0xa4/0xb8
     handle_softirqs.isra.0+0x100/0x3f8
     run_ktimerd+0x58/0xa8
     smpboot_thread_fn+0x204/0x338
     kthread+0x128/0x150
     ret_from_fork+0x10/0x20

The lock isn't part of the lifetime of the pps_device object, so I think
fixing that really is as simple as not holding the raw lock across the
wakeup, something like below?

diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index dc7fac75ec27..f85929d01e3d 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -203,17 +203,16 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 
 		captured = ~0;
 	}
 
 	pps_kc_event(pps, ts, event);
+	if (captured)
+		pps->last_ev++;
+	raw_spin_unlock_irqrestore(&pps->lock, flags);
 
 	/* Wake up if captured something */
 	if (captured) {
-		pps->last_ev++;
 		wake_up_interruptible_all(&pps->queue);
-
 		kill_fasync(&pps->async_queue, SIGIO, POLL_IN);
 	}
-
-	raw_spin_unlock_irqrestore(&pps->lock, flags);
 }
 EXPORT_SYMBOL(pps_event);

Thanks,
Calvin

> diff --git a/drivers/pps/pps.c b/drivers/pps/pps.c
> index de1122bb69ea..75eb7973e37c 100644
> --- a/drivers/pps/pps.c
> +++ b/drivers/pps/pps.c
> @@ -106,12 +106,12 @@ static long pps_cdev_ioctl(struct file *file,
>  	case PPS_GETPARAMS:
>  		dev_dbg(&pps->dev, "PPS_GETPARAMS\n");
>  
> -		spin_lock_irq(&pps->lock);
> +		raw_spin_lock_irq(&pps->lock);
>  
>  		/* Get the current parameters */
>  		params = pps->params;
>  
> -		spin_unlock_irq(&pps->lock);
> +		raw_spin_unlock_irq(&pps->lock);
>  
>  		err = copy_to_user(uarg, &params, sizeof(struct pps_kparams));
>  		if (err)
> @@ -142,7 +142,7 @@ static long pps_cdev_ioctl(struct file *file,
>  			return -EINVAL;
>  		}
>  
> -		spin_lock_irq(&pps->lock);
> +		raw_spin_lock_irq(&pps->lock);
>  
>  		/* Save the new parameters */
>  		pps->params = params;
> @@ -166,7 +166,7 @@ static long pps_cdev_ioctl(struct file *file,
>  		pps->params.assert_off_tu.flags = 0;
>  		pps->params.clear_off_tu.flags = 0;
>  
> -		spin_unlock_irq(&pps->lock);
> +		raw_spin_unlock_irq(&pps->lock);
>  
>  		break;
>  
> @@ -193,7 +193,7 @@ static long pps_cdev_ioctl(struct file *file,
>  			return err;
>  
>  		/* Return the fetched timestamp and save last fetched event  */
> -		spin_lock_irq(&pps->lock);
> +		raw_spin_lock_irq(&pps->lock);
>  
>  		pps->last_fetched_ev = pps->last_ev;
>  
> @@ -203,7 +203,7 @@ static long pps_cdev_ioctl(struct file *file,
>  		fdata.info.clear_tu = pps->clear_tu;
>  		fdata.info.current_mode = pps->current_mode;
>  
> -		spin_unlock_irq(&pps->lock);
> +		raw_spin_unlock_irq(&pps->lock);
>  
>  		err = copy_to_user(uarg, &fdata, sizeof(struct pps_fdata));
>  		if (err)
> @@ -281,7 +281,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
>  			return err;
>  
>  		/* Return the fetched timestamp and save last fetched event  */
> -		spin_lock_irq(&pps->lock);
> +		raw_spin_lock_irq(&pps->lock);
>  
>  		pps->last_fetched_ev = pps->last_ev;
>  
> @@ -294,7 +294,7 @@ static long pps_cdev_compat_ioctl(struct file *file,
>  		memcpy(&compat.info.clear_tu, &pps->clear_tu,
>  				sizeof(struct pps_ktime_compat));
>  
> -		spin_unlock_irq(&pps->lock);
> +		raw_spin_unlock_irq(&pps->lock);
>  
>  		return copy_to_user(uarg, &compat,
>  				sizeof(struct pps_fdata_compat)) ? -EFAULT : 0;
> diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
> index aab0aebb529e..f2fe504071ed 100644
> --- a/include/linux/pps_kernel.h
> +++ b/include/linux/pps_kernel.h
> @@ -59,7 +59,7 @@ struct pps_device {
>  	void const *lookup_cookie;		/* For pps_lookup_dev() only */
>  	struct device dev;
>  	struct fasync_struct *async_queue;	/* fasync method */
> -	spinlock_t lock;
> +	raw_spinlock_t lock;
>  };
>  
>  /*
> -- 
> 2.47.3
> 
