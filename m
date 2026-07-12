Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84303265620
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892639; cv=none; b=CvzDOO7CnUhIbJTxaHE/KF5jvPkqcDjBgXjxiSBoU+qVKEpqSSeAs3TTQZHJfYSd/fj9F53vMyy3Ho2uZKiM16fM34p91XRiH4EXHHRJ28mYv2+3LP96YxtjSRGHMNkCSfF2x9NbpnPf5UVUg61sra7Jo54SyDGaXtAZT/x4FdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892639; c=relaxed/simple;
	bh=Ncd+Nr6ElASUJrESkoYzFZAFZojPrdkqIeZ6KwQJ7lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=jehfgz+ENl2Ovw2+mFPXSgvg4SofABuhKyc/KhU9tyuHuxXvImHyQyTaaWgbvvaffyvyhx3rzcemIrQQ2DQ17Q+nNBEMibNytMm4hBM9M5nvkskSxCF2BPzwg4sNknR/uZPTAd5Bb7v9UqRk9ju7VXZsjdE5PRnDz2rDcMPhstA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gSXo2yXh; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gSXo2yXh"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so16044865e9.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 14:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783892636; x=1784497436; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HCxD8V4rPJmnTk5Z484eCKRQlIsY0VOuU0QQtm5539w=;
        b=gSXo2yXh3LWx0cvUUdD9sI+d+qTx8q7xgopVBQKUxj3a5yQrIMgRvcxkguCSkU1LAT
         eHaAvDfKtQPmNfTEdl+SJ8lIzMTNipITC2luYmPaa6N2Gshz1CGI+2ATi3JEk/oROEBM
         qH5m8vwgFKmW/H8L7J3BXErvxKgGmsHVm2/DmEAwrOfOEb8C7No5Lq600Nu0yI0PNHem
         9K0rRnVy6BaMrKhqClGIH2zCkbLF+g2SR+FF3u8oYVo8LyCCZ2WTx08jucNWoZ7PL5o0
         w6rTCVtw5aaxhaPLq7PH/p3NEHQqFnGHa4gMwz1jgWYtGtNK+edKt7tbjF2aK0ayxkr1
         bqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783892636; x=1784497436;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HCxD8V4rPJmnTk5Z484eCKRQlIsY0VOuU0QQtm5539w=;
        b=ZJ5RZ5uvsk0Fpt2wPHd7Ozt2GmxiPsNju6jFVf2urqo9yipHKmUt1nCpaR2oc42FXj
         XH/9SbgRCD/NN+nGpBcCENHwvTBHtOHUkPaf/B6R3g6l20NYNkeeXkR3UfeCfFff788M
         J0JU+C2qxUqRoTmea+X27aufgaWfJml0b42rHKpDzSXYmhGafBQA3QHzDkh1z4ZwswL7
         qF+azJNMMiG8HgeHPcRAf4s/NkRHYlCkYdfBshHyn0GJ+qNqvxoMfn9iAJ44KiHpl1Dl
         QjL3SphNymp1dxoDahWPO/LJIo95WzoV1Yy5u9BKf/KKezHH9JM2Oz0z5oDnymHg72Kn
         2gxg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0493Sh6E+C8k7rSFeJtyCt2xTDBWUMW3FZDQpe35gNPr88ZpvcIZo4/o3+BYYud1h/1UreJiMZMb/6diWTA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxysl425EAd12Go4X0pyNwCbxMaGtb5G3eNTxA1Ij2mUhHLuxj8
	mKoyvj3WCAKhp2+7k0wDc06tZnzLpzJF6yFxQh8l0lb+Tj/LkUdO6NeZ
X-Gm-Gg: AfdE7ckz+UzYIRJU6tOQWipsB05/ia6r4/2vzmd738w7q9sFcJP9h5RKNoWFrObza/B
	c51mgvX3wZ3xsLi2v2Wi8CQpv2tIYncIkX5WMJGo2SxetLuUZ9N0qeaBV0sNunwL2MVtGqW5PVu
	y9HmAeC1Mr/msSMF7T4GeBOhehNY/yC75MME8i5UQPE1LEsl3TxRcO0F8SYzDVOdoXXKoVutqUN
	DDsD/FMh7HirHyQPnmTfLDcXCFHqfZpAbU94LIioW02gaHUn9eZGuetrRkzgdTyoDBq4DH3Fbjx
	0/oO7rAXYnNPtGdD/wBSzkg0JXvWRUaZ7nD9gwLBnj8nydZIL8Zjk/jKt2pjChcT3UDSrNizcnO
	CPAk05Jzw5DcGZjZ6T0yK+y1w939MYXgFQDj20unZuRl18R6w1IAo/+bXvKeTZqxjzLnlas0Cmx
	9tXe0HAoh0HO33eLF0kcNNTA==
X-Received: by 2002:a05:600c:4691:b0:493:f764:1f69 with SMTP id 5b1f17b1804b1-493f87d5d44mr61691195e9.8.1783892635821;
        Sun, 12 Jul 2026 14:43:55 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ffd304d8sm42196365e9.0.2026.07.12.14.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:43:55 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 3/4] swap: apply new pw_queue_on() interface
Date: Sun, 12 Jul 2026 18:43:48 -0300
Message-ID: <alQKlBaKIOAxMzc2@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260520150736.HZnlFkv7@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-4-leobras.c@gmail.com> <20260520150736.HZnlFkv7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 05:07:36PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-18 22:27:49 [-0300], Leonardo Bras wrote:
> 
> after digesting the slub patch,
> 
> > @@ -882,38 +879,38 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
> >  	 * If the paired barrier is done at any later step, e.g. after the
> >  	 * loop, CPU #x will just exit at (C) and miss flushing out all of its
> >  	 * added pages.
> >  	 */
> >  	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
> >  	smp_mb();
> >  
> >  	cpumask_clear(&has_mm_work);
> >  	cpumask_clear(&has_bh_work);
> >  	for_each_online_cpu(cpu) {
> > -		struct work_struct *mm_work = &per_cpu(lru_add_drain_work, cpu);
> > +		struct pw_struct *mm_pw = &per_cpu(lru_add_drain_pw, cpu);
> >  		struct work_struct *bh_work = &per_cpu(bh_add_drain_work, cpu);
> >  
> >  		if (cpu_needs_mm_drain(cpu)) {
> > -			INIT_WORK(mm_work, lru_add_drain_per_cpu);
> > -			queue_work_on(cpu, mm_percpu_wq, mm_work);
> > +			INIT_PW(mm_pw, lru_add_drain_per_cpu, cpu);
> > +			pw_queue_on(cpu, mm_percpu_wq, mm_pw);
> >  			__cpumask_set_cpu(cpu, &has_mm_work);
> >  		}
> >  
> >  		if (cpu_needs_bh_drain(cpu)) {
> >  			INIT_WORK(bh_work, bh_add_drain_per_cpu);
> >  			queue_work_on(cpu, mm_percpu_wq, bh_work);
> >  			__cpumask_set_cpu(cpu, &has_bh_work);
> >  		}
> >  	}
> >  
> >  	for_each_cpu(cpu, &has_mm_work)
> > -		flush_work(&per_cpu(lru_add_drain_work, cpu));
> > +		pw_flush(&per_cpu(lru_add_drain_pw, cpu));
> >  
> >  	for_each_cpu(cpu, &has_bh_work)
> >  		flush_work(&per_cpu(bh_add_drain_work, cpu));
> 
> Why do we have two iterations here? Is it just a proof of concept that
> is not complete yet? I am curious why it is okay/needed to "remove" the
> one workqueue but not the other. Maybe the other does not bother as much
> as the other does.

Argh, sorry about the above :/

Slub was converted on a previous patchset version, and rebasing worked 
fine. I should have properly checked if any other mechanism was added in 
the file, but ended up just checking the one that was already converted.

> 
> But essentially we can't use a spin_lock_t here because due to the
> hotpath nature of the code it will kill performance. 

Correct

> So instead we do it
> anyway but behind a switch so that only those suffer from this that do
> not want to suffer from workqueue interruption on a NOHZ full system,
> right?

Yes, one can choose to pay the price to use spinlocks here and have less 
workqueue interruptions, if !CONFIG_PREEMPT_RT

In case of CONFIG_PREEMPT_RT, we have the local_lock() already becoming a 
rt_spinlock(), so it already pays the price to hold the lock. So it should 
be basically free on this scenario, and save time by doing the operation 
remotelly instead of scheduling it.
 
> 
> I thought that this improved since commit
>   ff042f4a9b050 ("mm: lru_cache_disable: replace work queue synchronization with synchronize_rcu")
> 
> Did it get worse or was it not entirely gone?
> 

I worked in this patchset majorly after that commit date, and it was still 
an issue up to last time Marcelo tested. Not sure of the impact of above 
commit, but I suppose it may have brought some improvements without fully 
fixing it.

Thanks!
Leo
