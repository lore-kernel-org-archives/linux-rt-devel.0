Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557C3306B08;
	Wed, 20 May 2026 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779288459; cv=none; b=d4YOWRH4SLPaP4HwAQBuVlnBUenQlQwsjEfBhgS+RNPjGtglxMCrMS8mXH4CVU6QFpHTrssNGwXwDaq6opOuDMxOSJ78PWM6qtb4j6M2IKmwIoBzn+Z+6d82I4VpetWICoARnEHRIM7MkHKdbf28pwwUEI9jqA3MvfM0/iu6yhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779288459; c=relaxed/simple;
	bh=pLu+up5ExjsmdYY6KizsZ7GS3/NPRMf5fOn8EHaWnQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U10b88Uk5GzTegV8k1nukLLWdkAfKaVYh+Aje/uo6eRRu5KqaIuGvIoSjoZFPO5z865M4u20boG30ut+LxmqhGEhEmeQasYWVB2n+fVxaS+cS2Ws4pb7AQvF5SAOYDqlVpDrdL3QpIhIs0hRqx9x2w5EhnX9QZRTJ40lLmRt4HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeB8Rmgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeB8Rmgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FD31F000E9;
	Wed, 20 May 2026 14:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779288457;
	bh=O2RCHoSb5AXLNUZZbMLGGEDeZ4b7SlXf1yZ924yOPQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MeB8RmgdeqXx0OiIdtL4BpvMTEFwxD54ehryvlqrGt8hWL+w8Vnguq355GGGVq126
	 lIBvOpdEC7DMJpEFFVUBZnqx5wU7g1T85j86mA+YweTWs5JmA0mDcQ2Krb4kInQDna
	 tI/OEb8eLhV6oVFlAg3fd8VsKpoCJ8uFldfzekI583E72sGfnKKA6FYn8S6BOopX8t
	 2vkBwrJSeBsd0F9+TcT7sUpC+ItW2+Am0bhewJtsRV+lQNKaxNoVMIQqwCmRf3A2oP
	 sZ+o3mi9KnTWeDYCCOODsIhCmPXD1f+IQ9FHrhwaGO54w1XdoP0F+tqpkA0ljKoMtu
	 T6dwMMki7gRPA==
Date: Wed, 20 May 2026 16:47:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Leonardo Bras <leobras.c@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
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
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>, Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>, Masahiro Yamada <masahiroy@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush
 work
Message-ID: <ag3Jh-8iUdgKvw5y@localhost.localdomain>
References: <20260519012754.240804-1-leobras.c@gmail.com>
 <20260519012754.240804-2-leobras.c@gmail.com>
 <20260520134832.WS7TrMnu@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260520134832.WS7TrMnu@linutronix.de>

Le Wed, May 20, 2026 at 03:48:32PM +0200, Sebastian Andrzej Siewior a écrit :
> How likely is it, that you you had users before late_initcall()? Also
> can it happen that one of them uses one function to lock and the other
> unlock in this brief window? There is no check if this was used before
> static_branch usage.

Or let alone initialization on the wrong member of the union.

-- 
Frederic Weisbecker
SUSE Labs
