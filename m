Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E338F63D
	for <linux-rt-devel@lists.linux.dev>; Mon, 13 Jul 2026 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927923; cv=none; b=Jf4lg0qVNALLFqRV2iX23m9dnVzX35zMZ+F/8gYNX4fl0hd5aph+d7SoXrP+xhB3dX7zebrYYOt/I9f0YfcwMIdutiX/b3tIJNUpNFWWRNHP630DDLOsUV63qSY8itPbrQMuZ9I7pSIet9QAfeW/2Uld5RvZOrgiUFbiPflgEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927923; c=relaxed/simple;
	bh=GCFNw7yoOEaZPIMYweHWnYZkMho8PhFCdAZweeUSrvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvlNmVWQWQdTvmA84IE5ajeFAat/agO4HtM4oiaHTW7uSIfZogMuTm3+4aWrnwBG0M2B6NAUu2DjB5pohishaSXe8cZRDX6SiMDzaV+ObFrteatYg6MJInE+phJbpP7XCU4VR+nbv/al9xPfJN87vi/gplLp9cF3ZUvtvU8o1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZyRRVaaN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d10LyRPT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZyRRVaaN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d10LyRPT"
Date: Mon, 13 Jul 2026 09:31:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783927920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTEFeO/5EIAP2AE6MFktsovFd8RdOZrL0IsFXTdIgCk=;
	b=ZyRRVaaN/a7Av7n45HMCnrFZ7sdvcF8hzCP7uNhbjBapw+aHEDtJjnEs1CrWFw+3ZF2hIv
	M3jHDVpzqCTVy5G9o5i9LomO/JobmAY9Pz7BMLALFhrVUWJDzrl6lnP1W5As75Uoio+A5w
	MfIcfb5hkJuJI5oX6N7sHyWavnOgSsI4N1ZJLcXZrbLDcwxD1dnFZSIRBJqDrLp8YLiJnj
	XAog1JjTU0XA1iv8403f5UcFofcWj69AZt78QBnKQa89hqhHGZGm8vFUTzlQKlRFYg+XoH
	2rfRcwR6Jvj2iu3gM56+RHj6Oz3Mvla6+PSMdIiAO+Vfsfn5CgVrCWF8RDyMxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783927920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eTEFeO/5EIAP2AE6MFktsovFd8RdOZrL0IsFXTdIgCk=;
	b=d10LyRPTmTNrbrJWbIolbyfdJhyGilwIxdwRklGSZNFcKFiW1zxvaina3PckVO0/A6wCzL
	oy0ppVgdLkkzKUDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Leonardo Bras <leobras.c@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>, Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 3/4] swap: apply new pw_queue_on() interface
Message-ID: <20260713073158.CHjwei-N@linutronix.de>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-4-leobras.c@gmail.com>
 <20260520150736.HZnlFkv7@linutronix.de>
 <alQKlBaKIOAxMzc2@WindFlash>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alQKlBaKIOAxMzc2@WindFlash>

On 2026-07-12 18:43:48 [-0300], Leonardo Bras wrote:
> > I thought that this improved since commit
> >   ff042f4a9b050 ("mm: lru_cache_disable: replace work queue synchronization with synchronize_rcu")
> > 
> > Did it get worse or was it not entirely gone?
> > 
> 
> I worked in this patchset majorly after that commit date, and it was still 
> an issue up to last time Marcelo tested. Not sure of the impact of above 
> commit, but I suppose it may have brought some improvements without fully 
> fixing it.

It would be good to know what is still missing and maybe it can be
addressed without introducing this remote locking.

> Thanks!
> Leo

Sebastian
