Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01E33A014
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783978142; cv=none; b=beSEX9jsvRrOD/BLdRUlhPktJsbqiA9sWqn597P7UoKpcm5ruKLK6vBbJpwLy+rIHqQFuHvmb2bKX1l1pKpK38Vgoc5lTmG5UZnOsb8WPvUXNpFFo4PnbwRQUQBbGF/jDXTJcnCLC1W5QZE2Ne3hJMwSRbqcr6QVyxUDt/9MMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783978142; c=relaxed/simple;
	bh=2ZrCZFXS5/VhTEv6Kj24OanhcNM15iH9nGjK/9R+4zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=R8xsNDPgB3zMgjqDWg8D6EXlDja6HyBVPgV3UiY2rltUxSyFwEfUd71vIZIwn/K+Jg9CnrJmBJhZYV/LDKbhVcLWIYvVzMNuCnBQmFQ/gAEZnfDPzGSMyNOseBDZ1vxYDOSeZIBd24DIah8lJbiZwvDnbl9kLs5Dy48k4JPJZ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oud4AY4U; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oud4AY4U"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so2018495e9.1
        for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 14:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783978139; x=1784582939; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQQoNjvYMy7swaXdt0/pPw+8PJHakFz/v63Sfote3Ss=;
        b=oud4AY4UU4JPMmm1UqU4pE+WxM5RGmXLpX/4o0cxc6pXclV/IoPe8vz6eVbhBqDA7Q
         EGATdrV1ikU5x403TIsgjQY1Qp4LDGq+E8BX1nBdnRQ/qOcvpVkPz9rXveS3NPuF60co
         tbzjb/+kkSRzOOMGAMjz7Cywgyeu9qxw8j8uz26VA61+TXDwThZgx8YiUqd1Tsntq91r
         TQLhVLacJtTaRPvzvUMr0120x1zCgYjpJOpZ1xBDawz2FgCQzV5QOiMtbANLwc/czESw
         xlQKUrjPVktpHsCIwqQb1Pja1bXXbXfTqtM85fDavCMi9zh7SzWhaY/LCu6v75zfGKg8
         nPGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783978139; x=1784582939;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZQQoNjvYMy7swaXdt0/pPw+8PJHakFz/v63Sfote3Ss=;
        b=mKVctUoK1dd82c/mZ3RQ8B5JSyI40Gzfkwa/QP0Z+VDtRLEnGlYqohL4OCcz/wF8tb
         /cVCYkry+yxGR8CW+CSkpQi5Ae5Am4YN6taaqTnogSiQ4MBM2mpHBPbjidpBvNNV4bcG
         RmH7cjjhJGIjAI0DUELK1SiWoJeK9okTO0T/DmJV3uRMk+ZDWALirlpCAVd9gkRTqsFb
         kOMb1qUS3XdDJkwNHg+zKu1BwSWwcnhayEnL4oCYCYqm7ickf/3MAW1Xe/ZCqPZPRvAg
         LZ3M/j4M6J7Aku5rNqZ3W3encHcBSHo/Ks8mKR8SRtTopZlVHIkgwilkJsRrBwee4rLn
         B3oA==
X-Forwarded-Encrypted: i=1; AHgh+RpQRXNvoCSp0aXj+22voJI9HESagKROBd+6d/tg5i0ytWvmg/vqJGxddQ7MraEYWbOQVJ0/jptKu+xfsxJv8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YyutYR01pnjWld6vAzlfagkP0/Agf2hIFtgm2/SN64cFLmu2jFs
	b+BxkBiXMRfSFpBieRpNNfCSLzhkoFXoe62dtMriF6725jZgyF3PTblP
X-Gm-Gg: AfdE7cnujMhvEnoHraxM5xOU8V7JKXV7s2t1wjUXpoKPs+hNkpZ82ahMOneO9ZsbpLp
	PMR0gROtRppKnrXRUHQ/N3aNjGjV2daCAFhLbLp7SkUauN16kGcQPaj52ppQhK82jQzqgYTxIL2
	vE/Nun5t/a999MUcyq14X7NrZg6eDVPVDTB7QPC/oOOf3IsjYRoMlDTgYhaMVA39B2LyJu4EmLW
	jF0wgUpviNpcNnGErdzbU0Pdd5PQqCWKyaZL6Bw+K43ptLeq9a3ohDciIkrR3ISMk2OGAO7hBHr
	6IlsTa0AAH1GfwcedK6jYM5qsAr3s0JBNzXdqkPA2jPRYwZg8gRDtWI2YYK55IolcXCYuTlr+kP
	EW3ZHcRyE/DoH7eM0hpCRr99QgMHvpHarQTQ0gFJslMxbShKrksBEZke+Qy/KPJvsU5cMG4VJo6
	OAN2QtsKDg/UrOrLKYAekDe+mgLW6AjqCi
X-Received: by 2002:a05:600c:6989:b0:493:bfbf:1da4 with SMTP id 5b1f17b1804b1-493f881de65mr104977295e9.22.1783978138921;
        Mon, 13 Jul 2026 14:28:58 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635ac2esm2503549f8f.13.2026.07.13.14.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 14:28:58 -0700 (PDT)
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
Date: Mon, 13 Jul 2026 18:28:52 -0300
Message-ID: <alVYlIPpCEUNBjeA@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713073158.CHjwei-N@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-4-leobras.c@gmail.com> <20260520150736.HZnlFkv7@linutronix.de> <alQKlBaKIOAxMzc2@WindFlash> <20260713073158.CHjwei-N@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Jul 13, 2026 at 09:31:58AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-12 18:43:48 [-0300], Leonardo Bras wrote:
> > > I thought that this improved since commit
> > >   ff042f4a9b050 ("mm: lru_cache_disable: replace work queue synchronization with synchronize_rcu")
> > > 
> > > Did it get worse or was it not entirely gone?
> > > 
> > 
> > I worked in this patchset majorly after that commit date, and it was still 
> > an issue up to last time Marcelo tested. Not sure of the impact of above 
> > commit, but I suppose it may have brought some improvements without fully 
> > fixing it.
> 
> It would be good to know what is still missing and maybe it can be
> addressed without introducing this remote locking.
> 

I get the point, but the main idea is to make this as proof of concept of 
the mechanism, that can use to solve the latency introduced by IPIs from 
per-cpu workqueues.

I remember discussing all those examples with Marcelo in the past, and IIRC 
to solve this we would either have to use per-cpu spinlocks, which is 
undesired in terms of performance on !RT, or skip remote operations in 
isolated cpus, which may have weird behaviors, or disable caches in 
isolated cpus which is terrible for performance there.

In any case, the main goal is to get something generic enough to deal with 
most cases, not an individual solution.

Thanks!
Leo
