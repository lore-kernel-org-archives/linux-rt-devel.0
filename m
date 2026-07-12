Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E14383991
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895738; cv=none; b=eMuUB2SF/9j+xVa/UVNuSquusySwGIRxliFCEb3tCh2AgEIkzMUYZzWhSoFf6cjUId1GuDKpuHDomybwqrcVmYoM0SrpteEBS2+FavVz1i5EJVNcUnYm7d5v/14NbF5ozJwC4pKuhXoVN8pHJHpaJn8Dno8MsxbAk783htaApvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895738; c=relaxed/simple;
	bh=zTp1DOk3NOaMktG3fJiFhErNH/BB+SGW2xP7NajgGuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=pUQM0Pd75vxGsIga+TfvMxGwAP8yKs8qYDjbsKb2lOj8VGSrcIKpfqHf61z7P9QvO3glmaNbXX9S+X96TQZKSSN7HyhCyUXbbrV1khP26ejn6NiH1LCGKhueKVRar42KvYA6p62fw6vFkbH1BM/hfqArhX1TQhd7E6GO5v0O7LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liDEw+Nm; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liDEw+Nm"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493ae59eca6so11316655e9.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783895735; x=1784500535; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VdrKql7RKB+YZLcnGXRPhjkopfqYReRcnCWxRaESO50=;
        b=liDEw+Nmu3hoFF/FAQnqRPRsXpD+lydzCMFFPdF7vzeqII7Qw25weSBpr/MSyOSo6q
         1zDNDrq7PQK8KNn5QzFH5L9fMu/3kEg8CLcJwC4BlClZ1kiwg3tsZObc7ZGLZzIVf/oc
         CAfM4jnVcP18CjyhjdpAx7tdEzquR8W6PnxgxaOGr27gzSH2ocAKNPsK7PHF1T1wcacj
         W50u2RlMlTOyl3D96jfEJo2UatmBosVpjihbc2FEpxYOWore33anZGtv9oAuq2Pppc8h
         eWjwW3DeAk3RFnHP2MVmUxlQxnRaQ/i59kWC89YZTZmgCvCh5wpxUYY1jrG1Uxx5P/oW
         HvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895735; x=1784500535;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VdrKql7RKB+YZLcnGXRPhjkopfqYReRcnCWxRaESO50=;
        b=XS69i+Qt52oGAhO+iTxCZZFY9SDBrMs1Uvt1/beEOGY1m8Df1CbLmuDni65br5ISt4
         yJdmSmRhOw7fY0rTMssRA9vT0zoOfHa4OAUkf6MlIzP1II4aPawFTWmlJbp9yKpo+wZ7
         1QSrygelFq56CJ6dYLddE9jdE2ZDh95jSUKDqzaK3tCX4xhcPCreqUIcnMFXyYzvvpoK
         UP30xsyG0fwyEHz3C0Mv/9ta+MTQCp2CMSOt4Y7pnoKpccZgaAoHwzhLJ1yg+bjD2+Zc
         /ccdOzRrBwT9DBaZFXFgU9V8zOlI1YgVLQ/pOjPUyek1Q6uSN5qfk43SAdj4le6ZkuMW
         XuhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoxRNS3IZBz9L3gHYAjAUqaTg4tiE0JGvgrtfqid0YzzLQ8YCImT6orWJeuRAE80HP0gftnBOQ2uH/lSJAVdw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxKojhseHUiaYRJ4ZsmY+T5TvX6wibCPmHGxQZHTsRWdRKKRUyD
	9pECTsTMRhyqlIOZF53zQK17TvuWSd5EnabJJMkAXRAln2cKQI+IY1lk
X-Gm-Gg: AfdE7cl1Vm3IuChdO3j8DjhYpdaArsj//x+mvL1PEqaZdIlcONR7t7QCSl1Wxf7C2gl
	W2z0F7ZSprlYaE5B7Q+ECcngdzYQAwugNkRdnBS5bu1zW9+XQ942PhFhNY8WsE0RS17q/VYunI8
	rVgs7txl9oB3Oo1/ARzIkhjkoTLxkdErM65TnRfGoZgplTnxXV7W2cw26vd/w6ZEGV5wZZkMbQo
	NnioBNsJj3Mb97alk2Ak6fXxxQqoW5ceoUFowWbfAOTOPwxmzF94QSiuZFi4D8UOWfNQgx8pmC6
	Ge9GSbnWCx6brH/yVUlub2hgK9YibfqS963IEbA46aQnM03SKJF4v4/Fl9fx1jdNlPA+m/1IMFn
	TQRefQttjQPyaG/zvdRh/whQep7Qrsh+SPrXf19CsIJtQglZsa8IhAXBgzzcuk8n+yeyQdiCYXL
	MNpazvjwNA+EElgPdO6f8qMA==
X-Received: by 2002:a05:600c:6989:b0:493:bfbf:1da4 with SMTP id 5b1f17b1804b1-493f881de65mr64503975e9.22.1783895735000;
        Sun, 12 Jul 2026 15:35:35 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6df6d9sm373068445e9.7.2026.07.12.15.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:35:34 -0700 (PDT)
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
Subject: Re: [PATCH v4 4/4] slub: apply new pw_queue_on() interface
Date: Sun, 12 Jul 2026 19:35:28 -0300
Message-ID: <alQWr2L_Kn23pxd9@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260520145308.nay9zt6r@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-5-leobras.c@gmail.com> <20260520145308.nay9zt6r@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 04:53:08PM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-05-18 22:27:50 [-0300], Leonardo Bras wrote:
> > @@ -4733,121 +4735,121 @@ void *alloc_from_pcs(struct kmem_cache *s, gfp_t gfp, int node)
> >  
> >  	/*
> >  	 * We assume the percpu sheaves contain only local objects although it's
> >  	 * not completely guaranteed, so we verify later.
> >  	 */
> >  	if (unlikely(node_requested && node != numa_mem_id())) {
> >  		stat(s, ALLOC_NODE_MISMATCH);
> >  		return NULL;
> >  	}
> >  
> > -	if (!local_trylock(&s->cpu_sheaves->lock))
> > +	if (!pw_trylock_local(&s->cpu_sheaves->lock))
> >  		return NULL;
> 
> alloc_from_pcs() can be called from kmalloc_nolock()/ NMI context.
> I don't remember why exactly local_trylock_t was introduced here instead
> of a per-CPU spinlock_t. 

Probably to save the cost of using atomic operations on locking, and having 
about the same restrictions that would allow using local_locks

> But there should be nothing wrong with a
> trylock on it from NMI as you do here.

Awesome!

> 
> One thing worth noting, on !PREEMPT_RT, spin_trylock() always succeeds
> on UP. kmalloc_nolock() checks for it, not sure about other callers.


Sorry, I did not sure I understand that part. 
You mean we have since it always returns true, we may be in NMI context, 
after it was interrupted holding this lock, and it will return true which 
will use the protected area even though the lock should avoid it?

Humm, but if that scenario exist, then is it actually ok to return true on 
trylock() in that scenario?

Thanks!
Leo
