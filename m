Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B229ACC5
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977452; cv=none; b=rrMWsItjQ74JQuA2fW+HWeQHGKKC401MbtTC8jaDfHjmCjaV7W/klhyzonpKHZ//V+P/WOp+NqXDDDQCNu06epRCAApMTchagXpHH86/HtyPOhuVjoHti9G+/jBMLDZBvWHTwM2aao0A3a2VuLS4eDr9RTUQeSV+d1zRTFnzxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977452; c=relaxed/simple;
	bh=ESZSUj+QsiIF6nv0NbuhSDu+P6Pwr5U/SNiDVxlW6sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=HptEz1Ybc4OBZ2UFOY9s5UoRcmAOK2EJy2soW2EsdVYCz9T81XICG/iWOgZjdKTk+zvMgnNkxta9KRIhAFfZTWzdy3PBBCJfO/EZL9Ud/vVRHgshrPQM02HYU0y+UZ1WEYAlm4cAph1Wj+uBT9/yoLXKCC4rSXbvUh3FKIor65Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFip5/L+; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFip5/L+"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so415086a12.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 14:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783977449; x=1784582249; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=npiX22YSguzWJpXGx2hHTXeW3ywrBRl4LUKqa1yh85s=;
        b=HFip5/L+8Pcub0ThIYxolByL3RTm6hA6S7MVpl3n/LL9hoqC2QInnD1fTlZ4m0qrP3
         2a4/CQTKLHO7XeApeehzLx3FsXCZVlaApkXsHj4BAAaQ19mdRIiQGo8Oh3l9su+42iyW
         UjWl6OxeJPaaRPFJint7m9vAGnrjiAWJAO2nK6xTZ6UdneyB0Lp6QsaDjF4UPchOQI+d
         7b2rA3BdDKVCw6tMppHr5v3Ej+74JD9+E/sphHzCtAYzdozERJxXgn6u7E0K45v5th0n
         5VOBdvF04uklsBWu/opEOIV8/BAVChB5llFo+HeqdPqamGMhbroWwNCugxdOsK+sQS19
         5DAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783977449; x=1784582249;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=npiX22YSguzWJpXGx2hHTXeW3ywrBRl4LUKqa1yh85s=;
        b=sFzmZSKLOQ+RrWtPSpPwOfrAj3PcAKKvfRQW6DJ1rJ0yexArC0pjj3TqQYjFaWsS3H
         0rSWXFmaGLnRFJIJq1veDj4Hfzz7hDvKQ+V6qaENQY6Ap3/gJbdfF0QIJ0YewuB97mN5
         A+tEf+qTpTjbDZyUZQndgYiOibszLL/N8l/stUPop5gAVQAWkRatJ9tCaMY8sA2QJgRz
         Wu/6fmEnx/6GtLc1kZBIHK1gJEDV83FP+CwTFp8Duy4sQdH33X5BYSzhhb5JoptRqn9H
         mfZUVzwA3o5P6bYjPHiHnMxgwbPdT5uD5sOo0gb9M2lWtsml4OW+mWAORxWVKEeqyTki
         hwmw==
X-Forwarded-Encrypted: i=1; AHgh+RrJkQBmzIWWt63LXinShFFOaZb6epAUZ8LzOJcyitt6R9SyhjlLk/LOYqoJVInH2z5v4oSuGFqgOJZTPcUB+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzls/gBeUBH8hi28l0walF0IIQ/loOjoto1/fOVxoSFONaBihLw
	Toi2Cg6np4eMNhINJQSWF5/b0L9G0NXtQyPFc+X5u7xlJA7dift9JxDN
X-Gm-Gg: AfdE7ckVn1agVCqOPaZDV1GK9nLcEixyk5ss3GFDjpI2OwHjG899NCp037J36EC0YhP
	sCVVToo32qIZymBhl9aVSKO2Mp+i3ePeAs2GLtu0Ckl2RbvuWs8rJ7kjyQZLXWrinVVtBn5hT5n
	SsCMkPqzG33DvY50WmZW87VTrPGWepXy9oTa/xz3KwW842oYRheI2ZaQv2s599QhkCOAAFnJqzu
	gtkcit9qdxdujsmv97IlV2K8EsK0Ehhr/M4kr7V5AbgNqgLK97gN71vXe2ujFdLOElnXcHzyCXk
	mzwxWXhaYK31hoByxlD/JX/93mQkfeElodYibxj1BBVKLzQWW5UfhlweGC5ue4gShgJtdMutIyJ
	eMzQya5X4kWGvWDLYC/zVro1CrxMA9Z6iuz6DPKmXmsA+bx6cXtV9W2cQR+JJ/ukwShov5WOLqE
	Zen3hCpvOETfLozbI2o2h1YSoU4jL9AXeg
X-Received: by 2002:a05:6402:3220:b0:698:ad7f:9383 with SMTP id 4fb4d7f45d1cf-69c5f0c3130mr4880740a12.14.1783977448821;
        Mon, 13 Jul 2026 14:17:28 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69cd2952836sm386903a12.27.2026.07.13.14.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:17:27 -0700 (PDT)
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
	Thomas Gleixner <tglx@kernel.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Coiby Xu <coxu@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4 0/4] Introduce Per-CPU Work helpers (was QPW)
Date: Mon, 13 Jul 2026 18:17:23 -0300
Message-ID: <alVV44RO_SolaqMW@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713080723.XOTiibfG@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260520130903.Ebsd4aUa@linutronix.de> <alP58SgTc2_8OFPc@WindFlash> <20260713080723.XOTiibfG@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 13, 2026 at 10:07:23AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-12 17:32:49 [-0300], Leonardo Bras wrote:
> > > > The idea:
> > > > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > 
> > Hi Sebastian, thank you for reviewing!
> > (Sorry for the delay)
> > 
> > > It does not become a _spin_lock because it does not spin. It sleeps.
> > 
> > Right, it's a per-cpu mutex. 
> > My point is that it's a full lock, and we could use it instead of doing the 
> > whole scheduling thing, since we are already paying the 'atomic overhead' 
> > to get the lock here.
> 
> The whole lock is a spinlock_t. There is also raw_spinlock_t and
> bit_spin_lock(). All three are considered spinlocks.
> 
> > > > In this case, instead of scheduling work on a remote cpu, it should
> > > > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > > > work locally. That major cost, which is un/locking in every local function,
> > > > already happens in PREEMPT_RT.
> > > 
> > > We did have this before but only in the RT tree. It was a bit messy from
> > > the naming because it started with local_ but then it was a remote CPU.
> > 
> > Had the same naming issue here. This idea was initially a expansion to 
> > local_lock() mechanism, about the same way you were planning in the past.
> > 
> > > The main issue was the different code path which led to a few deadlocks
> > > back then.
> > > By the time local_lock_t went upstream, the cross-CPU locking was
> > > removed. As far as I remember, the cross-CPU user which did schedule
> > > work on a remote CPU and annoyed NOHZ folks were replaced.
> > 
> > I understand this could be a big issue if used in a generic way.
> > 
> > What I am proposing here a mechanism that standardizes those 
> > local_lock()+IPI strategies based on how they are done today, so we are 
> > only explected to get 'remote-cpu' pwlocks in the 'IPI replacement' 
> > operations.
> > 
> > The idea is pwlock_local* in every local function, and pwlock*(,cpu) in 
> > operations that can be remote. 
> > 
> > Maybe being used in a more constrained way, it has less chance of being an 
> > issue. Also, the whole idea is to improve CPU isolation numbers by 
> > reducing IPIs, so maybe NOHZ people will be happier with that :)
> 
> I get that part. The local_lock_t part is cheap on !RT and becomes a
> full lock on RT. While the lock details change the overall expectation
> remain the same. With this change it is possible to acquire the lock
> cross-CPU but this depends on the config/ setup. This might not be easy
> in terms of testing and maintenance.
> The more potential users you have, the better it might become in terms
> of a selling argument. If you have just (say) two users it might be
> simpler to address just those.
> 

IIRC there are multiple users of this mechanism around the kernel. I 
remember picking the first three (swap, slub and memcontrol) as examples of 
how to use pwlocks (QPW at the time). With the concept proven, I could then 
proceed to work with other potential users to replace it. (We ended up 
dropping memcontrol in the process)

The main idea is to replace as many potential users as possible to reduce 
as much as possible the amount of IPIs in isolated cpus, and allow Linux 
to run workloads which require much lower latency.

This idea came as a general solution to a bunch of latency violations  
Marcelo and I were coming across.

Thanks!
Leo
