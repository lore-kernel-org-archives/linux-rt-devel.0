Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D64352029
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 20:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783888381; cv=none; b=pDFw4x+ibHDCd7Mc15JbouzLy/6ccEX5ROSjmdC8EQRL7M/UfJp7VTq/hfuf9J1JspyipKDUhIzLwxEGYOZ+3QHi5TlHZ5uh9CzrHTMOjsHgL3NPbKBaz9irFKY/Swa0ytUgeqmKxsmwodXrzeMXuN4uv5ouncWkAjX5my10KNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783888381; c=relaxed/simple;
	bh=vIxocmQXXq6Vrqr+5uIHeLC+jGNN0zgOMuWrSgXpbzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=CmZx4cErqS3KnFfFKK7qshntC3EtcILVBasCKJqtqI+DsNhYI2iwhmHAdVn+3yw1qQICs0sWtS1MGlkPZHzYZz1dVlDqZuIWgxViM5OTC1sMKdd236LdmaFevG2yQf4yVI/CV0ErcBJB+iWCf4L0kRB9Dr1f0CbyzGPTW5RnukY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghFy7r1+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghFy7r1+"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-472326ca506so1935653f8f.2
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783888378; x=1784493178; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hoFLr1vfVTbyBPCDDFLHELDOVM+etETDJUoaDXyGSaU=;
        b=ghFy7r1+v78iaY/WeJYrAu3Aos2+dtuVHV7MikWHQDwBN2i9EooJpJ7e/muYQnpR7a
         O9KRy9a1urpFaWK0F2QE2c+wYhfjoPAPVudP07w+KfCzgtCrKX+ADlVjoF9RlbFX/V6u
         awZnyHPqrhBMd8jBCmDQzRPsljO2TcbNNPhWbAa2uz1xYljOHYDzO26Ob8U8PsRBNXuO
         bj5E/P9NDkcEjshKGT4jjNAHBcOMLGUSkpaF11Rn1CsNPPrK4nYdVpvOTwBK1bId7Ar5
         7RloV77JLBn0bYZAvity3u7y7taY3ixdf7JIEnz10FfNT8CBmB1ZSOUTJRbS8fQmwHtk
         w1Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783888378; x=1784493178;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hoFLr1vfVTbyBPCDDFLHELDOVM+etETDJUoaDXyGSaU=;
        b=sPxRg8HTH4ipmojDQvAxj9JKS2pGPgNuVxr8jk7gJZ9P5JQ1TinodIESgahpdhlMxJ
         s6zZBUU046rsy6CffaTjRIz9b+kwGpnz3yKUb4wskR/Qa5SMaRslqjqKgiRIzr0/nWI+
         rmugZPFrklSyd+qCNuc1Sbez3kMeFBzFtc0Qgs/ous8ozwt4DA8SdlusjRL0isS81NeF
         d/U7kktjTr3axr+lNB75i1TZkyO5HRY+C3olaJ/LNyhp6fQTHAYCb2qW1ufIyEMJ6JmQ
         W3u28m8+JxDQzZ2HMnJh26yklunP49i6yv7iNVkFMYklgu5SU5IcKMaKGqqgg+CounA0
         cjtg==
X-Forwarded-Encrypted: i=1; AHgh+Rr+Uia3XBlApW4yllmBLWT9awEELx4x9Uy0qTTF7T/T1o/ZT0gnyY0Hr/kHf8Tq/nbd5pOlnnCFZio91CWh/Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzih76mrEtogiNrGbRWa3iXdP4LNpCGfNLUkwXLXbQYqsOGyNL7
	3E5Qa1gJbm6bob0fBTWYNG5s2nAhYeeo9tqkxfdX4bPfUeGM/xNj+IZC
X-Gm-Gg: AfdE7cmXdw2KQUPLR8jz+F9RWSBKmnh33tjrinNlZxPcwhmU6nesi6drl/lIO6Y1k76
	m7/1+11xz5QcCLzxCB55z8eFNqMk4QfTUT5Srz7+KLk5hdnoAdq6v67Rh2ss1qfvy4JXcC2th5u
	KwUO4xobgnnQxPsd3F4GFaxI1xmOh0hOSwbfRL246oaKvSL+25l5RmQnLQbYSbwUp/HstwfxZrg
	RSyQbd4UCAv0OqnmQEYhJoFoEJFRayXOEUvqVSJn5iKNRKsx2JHQ81x9N2ZlEQbVwQQp0it9oTi
	xnO9zr0J/C/jvDFdgE44fTEihWreOGu+kPLpHTWu+NycWADp4PNfJZBt1lE4qV7HU54TiQUbdTr
	C+hTE32kI0CyzLtm6dpuk6HlL1QoOkp/k3K5wprCYGWg8YMvA85PyeTR1XkBkMOj4GadAgq48Q4
	GO3n/VqejoTFIyJ9MbXwiPQQ==
X-Received: by 2002:a05:600c:b99:b0:493:b61c:72c3 with SMTP id 5b1f17b1804b1-493f8829956mr66599105e9.32.1783888377859;
        Sun, 12 Jul 2026 13:32:57 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039af67sm88998034f8f.17.2026.07.12.13.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:32:57 -0700 (PDT)
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
Date: Sun, 12 Jul 2026 17:32:49 -0300
Message-ID: <alP58SgTc2_8OFPc@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260520130903.Ebsd4aUa@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260520130903.Ebsd4aUa@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 03:09:03PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-18 22:27:46 [-0300], Leonardo Bras wrote:
> > The problem:
> > Some places in the kernel implement a parallel programming strategy
> > consisting on local_locks() for most of the work, and some rare remote
> > operations are scheduled on target cpu. This keeps cache bouncing low since
> > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > kernels, even though the very few remote operations will be expensive due
> > to scheduling overhead.
> > 
> > On the other hand, for RT workloads this can represent a problem: getting
> > an important workload scheduled out to deal with remote requests is
> > sure to introduce unexpected deadline misses.
> > 
> > The idea:
> > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.

Hi Sebastian, thank you for reviewing!
(Sorry for the delay)

> It does not become a _spin_lock because it does not spin. It sleeps.

Right, it's a per-cpu mutex. 
My point is that it's a full lock, and we could use it instead of doing the 
whole scheduling thing, since we are already paying the 'atomic overhead' 
to get the lock here.

> 
> > In this case, instead of scheduling work on a remote cpu, it should
> > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > work locally. That major cost, which is un/locking in every local function,
> > already happens in PREEMPT_RT.
> 
> We did have this before but only in the RT tree. It was a bit messy from
> the naming because it started with local_ but then it was a remote CPU.

Had the same naming issue here. This idea was initially a expansion to 
local_lock() mechanism, about the same way you were planning in the past.

> The main issue was the different code path which led to a few deadlocks
> back then.
> By the time local_lock_t went upstream, the cross-CPU locking was
> removed. As far as I remember, the cross-CPU user which did schedule
> work on a remote CPU and annoyed NOHZ folks were replaced.

I understand this could be a big issue if used in a generic way.

What I am proposing here a mechanism that standardizes those 
local_lock()+IPI strategies based on how they are done today, so we are 
only explected to get 'remote-cpu' pwlocks in the 'IPI replacement' 
operations.

The idea is pwlock_local* in every local function, and pwlock*(,cpu) in 
operations that can be remote. 

Maybe being used in a more constrained way, it has less chance of being an 
issue. Also, the whole idea is to improve CPU isolation numbers by 
reducing IPIs, so maybe NOHZ people will be happier with that :)

Thanks again!
Leo
