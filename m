Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937F831CA6B
	for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 14:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757945619; cv=none; b=WXCgC+eSdJAFjuhK4j+M4tYlfJHOFlV6ZpmNkFXdLHfZyfSXjuZlaeerBj3Kzit+qfdegcW02yV5T2QQvR7vUpMe9b9MRzTZo88fv4R5eLcXZC1k/bQlAlgctVe3LLNwULXOkCSss5THsbuPySO/fpqgrij8VH6ztbt5SdtkJ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757945619; c=relaxed/simple;
	bh=mkgMTmzYeY0rzm54yxUzf2TFAaH/EdGznSYD6F61wO0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ieCN6WHs7oPDmItF5/fxz1j7fjs2Xzbs8EPX1Z1PIphDx1lguQFoVfvKfZlKiRg/BTYDdBJZ6suGYVKEECNJ7D9gwECT96zJQZHZpkf7x9gwGqCrAJPH3EFG5LGraONn3WSdLRh8ejEZ4fQsWXZW83KUwN5aHw4oRlbNPWkuUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S37sqI8z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S37sqI8z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757945616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wVdn0DPWHUbkLEPLdY+zWqs5jFzexOcoSsUmWxZ7iDA=;
	b=S37sqI8zwJ6iFn5NlfAkIcjrzB14jC+77o07utp5OWMx0g0C0qGU8SlEPaxHaOEyqsdNgU
	+qeZbwrVShiHUgEQEUaf0X0TH6teJJgaS55DiaZQLtLHU9trgW1b2Y1Nuq1ASON2wAlqEb
	1XR7XkU1INW8V+zt9GgGrWS55ZqLuYo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-xXxK5XJyMTKbSI59Yauaig-1; Mon, 15 Sep 2025 10:13:30 -0400
X-MC-Unique: xXxK5XJyMTKbSI59Yauaig-1
X-Mimecast-MFC-AGG-ID: xXxK5XJyMTKbSI59Yauaig_1757945610
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8078f1bc588so998033585a.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 15 Sep 2025 07:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757945610; x=1758550410;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wVdn0DPWHUbkLEPLdY+zWqs5jFzexOcoSsUmWxZ7iDA=;
        b=cI/CFXTPBOkZ7g/QGIBbhzIeplniMexVDsuXeFXoHqLBKCQY0ojYscHScr1Ycrkky/
         obYf0NkmldWT+g8VIOb4LJWjEKd3oRtReJM+J83Hi35rvkGBEL6tlJns69RQIt7H1mUj
         D8XSZb4sAbL7/B4hGaxZSQkmMGp0beGhuY7VFZSqX+/ysJfYs2T+OpZBJCtnM8Xa++kn
         WDsC96pmYEuuRppS4AWSvOQD+k9t8K8/c0SvmhSTq7AVnRClNgniQrOL3sEwDqUGUnb5
         JHZk2Y1r32rcFAMyV9d4ReeQ/gMTZTk04Et9CGnhNKyPmoyPdBahbEFVvptfqKnk11QF
         wQjw==
X-Forwarded-Encrypted: i=1; AJvYcCUUX3XcnLWORJhqYh1+qgCzDDwauDZwVQfiUQYRoWuQKsI/zsCQSJcEQVPxHPgBwD36mEjmzD/N49mafEe3WA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCFNBb7yo1Up0CPsnvKYvaJNDVCCAPTf6iYaeBC6xenKsHNy7f
	/KBpMFuHhU1cVUJEAvxC9b9v337r/D5Z/Om5nSQAWZCMr3ks2gzPPwWKmKfYBhMbjaoOMrMRGG/
	3HS6qWrirl60iL33ceFuvqWV2viELTdG1cUNcy74OJLaNwlCrRzWD9XL88mB5AXkxli0v
X-Gm-Gg: ASbGncvMBqJ5KCqJQkofzdU/LIrJXVRb9+hM1uZCLjdvPGDqoBG5J4Ova8NOdbx641g
	XyN8lsulJB3vzjr9DSjf/t//TtO62lI4rkBjAiIWFEEb9T5B/9JNB1H/Y3ezTJit1aTU8zkgFY8
	ILY9hBoqcrJN1CESCcYiUZbili4vgnVE5k5fde4/jIvTkIELIqvWGbdXc/5dPrM0/XQ2qhf08o1
	Ka4CYMB07r9vIM0A+Y/yHZ+bHcQ1tPYjHJEGV2mD12RyOqZ+dfiq/B1JD/Lrt8Ex7+OxjE6wG09
	pXOOWNGmyx2+IU9eIojvf6/H9aZ1SrdYFXgTDJIz0iRrJqo3+H18xJpvTzIrYwjQCraRRDyft0Y
	barJB9COxPw==
X-Received: by 2002:a05:6214:1c48:b0:783:aeed:f585 with SMTP id 6a1803df08f44-783aeedf838mr35484116d6.14.1757945609772;
        Mon, 15 Sep 2025 07:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTppRgm9Zr+i6yKV7XaF5zz8E26tx9E9U11cHDaiNozJpKImHlUxPb0H8lw3W3qvOa9oFD+g==
X-Received: by 2002:a05:6214:1c48:b0:783:aeed:f585 with SMTP id 6a1803df08f44-783aeedf838mr35483486d6.14.1757945609106;
        Mon, 15 Sep 2025 07:13:29 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-78903aec245sm7995186d6.23.2025.09.15.07.13.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 07:13:27 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <69af79b6-a4f2-4007-aef4-fcaeeadd3f99@redhat.com>
Date: Mon, 15 Sep 2025 10:13:26 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
To: pengdonglin <dolinux.peng@gmail.com>, tj@kernel.org, tony.luck@intel.com,
 jani.nikula@linux.intel.com, ap420073@gmail.com, jv@jvosburgh.net,
 freude@linux.ibm.com, bcrl@kvack.org, trondmy@kernel.org, kees@kernel.org
Cc: bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-s390@vger.kernel.org, cgroups@vger.kernel.org,
 Hillf Danton <hdanton@sina.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 pengdonglin <pengdonglin@xiaomi.com>
References: <20250915134729.1801557-1-dolinux.peng@gmail.com>
In-Reply-To: <20250915134729.1801557-1-dolinux.peng@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gexYcKkVHKjNAn-vNoJxTend8JowtfKvywHVzzgO1xM_1757945610
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/15/25 9:47 AM, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
> consolidation [2][3], RCU read-side critical sections include:
>    - Explicit rcu_read_lock()
>    - BH/interrupt/preemption-disabling regions
>    - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4])
>
> Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regions are redundant.
> This patch removes them, simplifying locking semantics while preserving RCU protection.
>
> [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU/rcu_dereference.rst#L407
> [2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.com/
> [3] https://lwn.net/Articles/777036/
> [4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@paulmck-laptop/
>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Hillf Danton <hdanton@sina.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> ---
> Changes in v2:
>    - Clarified commit message to prevent accidental backport to older kernels
>    - Added lockdep_is_held() to avoid false positives
> ---
>   drivers/acpi/apei/ghes.c                        | 2 --
>   drivers/gpu/drm/i915/gt/intel_ring_submission.c | 2 --
>   drivers/net/amt.c                               | 8 --------
>   drivers/net/bonding/bond_3ad.c                  | 2 --
>   drivers/net/wireless/ath/ath9k/xmit.c           | 2 --
>   drivers/s390/crypto/pkey_base.c                 | 3 ---
>   fs/aio.c                                        | 6 ++----
>   fs/nfs/callback_proc.c                          | 2 --
>   fs/nfs/nfs4state.c                              | 2 --
>   fs/nfs/pnfs.c                                   | 9 ---------
>   fs/nfs/pnfs_dev.c                               | 4 ----
>   ipc/msg.c                                       | 1 -
>   ipc/sem.c                                       | 1 -
>   ipc/shm.c                                       | 1 -
>   ipc/util.c                                      | 2 --
>   kernel/cgroup/cgroup.c                          | 2 --
>   kernel/cgroup/cpuset.c                          | 6 ------
>   kernel/cgroup/debug.c                           | 4 ----
>   net/mac80211/cfg.c                              | 2 --
>   net/mac80211/debugfs.c                          | 2 --
>   net/mac80211/debugfs_netdev.c                   | 2 --
>   net/mac80211/debugfs_sta.c                      | 2 --
>   net/mac80211/sta_info.c                         | 2 --
>   net/ncsi/ncsi-manage.c                          | 2 --
>   security/yama/yama_lsm.c                        | 4 ----
>   25 files changed, 2 insertions(+), 73 deletions(-)
>
  ...
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 27adb04df675..9b7e8e8e9411 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -4073,7 +4073,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   	struct cpuset *cs;
>   
>   	spin_lock_irqsave(&callback_lock, flags);
> -	rcu_read_lock();
>   
>   	cs = task_cs(tsk);
>   	if (cs != &top_cpuset)
> @@ -4095,7 +4094,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>   			cpumask_copy(pmask, possible_mask);
>   	}
>   
> -	rcu_read_unlock();
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   }
>   
> @@ -4168,9 +4166,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
>   	unsigned long flags;
>   
>   	spin_lock_irqsave(&callback_lock, flags);
> -	rcu_read_lock();
>   	guarantee_online_mems(task_cs(tsk), &mask);
> -	rcu_read_unlock();
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   
>   	return mask;
> @@ -4265,10 +4261,8 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
>   	/* Not hardwall and node outside mems_allowed: scan up cpusets */
>   	spin_lock_irqsave(&callback_lock, flags);
>   
> -	rcu_read_lock();
>   	cs = nearest_hardwall_ancestor(task_cs(current));
>   	allowed = node_isset(node, cs->mems_allowed);
> -	rcu_read_unlock();
>   
>   	spin_unlock_irqrestore(&callback_lock, flags);
>   	return allowed;

For cpuset,

Acked-by: Waiman Long <longman@redhat.com>

