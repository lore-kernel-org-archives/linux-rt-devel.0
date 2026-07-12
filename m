Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FCD3769F7
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 21:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891062; cv=none; b=FiOnXU1gpmaZuTs8nCDEQ1HnbXKhrEaFC3b4lJ9kPtpa7LrM7NcprB7tuPryFnbOW6r4+UqZCSB37Gy1brsl95FSbp+AMX/HUAeYqLMBRcbr+zuk+nrQlOYCAkT7GlVSVaDNBiZB4VypIEjwH0JS195hnvGgd8mwZnLh+b4Ef5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891062; c=relaxed/simple;
	bh=2LJzXj9ppebEulv72Db9DKrXEuSmBOMhC8AFnbyQWp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=jlFOq6+UC8vVH2vqmZ3BkirWz3jQsanTnqsliJJ6YzaCMyBJbVnSvY0PQSREM1VIw7PC843vcgEo3Dpd12rAGxXDpM//WjdWWS925zH7gbupMKblXTi06r95Ywzd9oE3vyDQWt77rk4DxLotr3sXdHD7U+7bWG9c8KDerjQQU3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na1B37fk; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na1B37fk"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47c6e9a694bso1339363f8f.1
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 14:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783891057; x=1784495857; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mO9PnufslFYNDwqPjTJ3f3FlkpnmJVQM4/pFUcrdNco=;
        b=na1B37fkVMeVGebAYVCBII3kBykUIx4gHa/9BLiW3U/43346WGm4kqqA/2CQcioUU/
         GVPtwRe9kiTjCdiaT9Gpgwz6f9VnCFAiM1uLxHilg9zDn5w6U8efii+qR2sKtE3OSQ5O
         WNBeA/txwR2FfIHkUqr7JfTwe+w8chvtwZfBeFutT1eYWKTsoq8kD3QSHa+2mKo4recc
         C44U6UwVP3atk1/tAEJLtJp6m55aV/gv5eA3xgMjSLBrW5OILOTU96GNhZ6JbEFzf9v7
         1YxSnUGcfpJabmt8HyzWUlmbsegR3fTgVrQNXLJOJjXEkwa55+HIt5W2R+k8+cs9qp8K
         QKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783891057; x=1784495857;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mO9PnufslFYNDwqPjTJ3f3FlkpnmJVQM4/pFUcrdNco=;
        b=ViMhYoj5FwUSveoYDbtzo3gPHKUoIofGeAqKsQdMc3Yow2VrNpV7JXzLlZIe9NQEBR
         FKtCf5388164g0fQfiYpTYbJ2ThYSwGt2iZBrB8PteqxG9hBGG0D58IX9HnTEkwQoo9V
         ddJc05by5Y9hyz6Td5Wt1eFSs/+nz/i98TSpIGtR8mkr4En6we3lu46p1EAbUkISDLZk
         R4eoqzS1nwqTEyWmbdABePL3v62ntk4A11m+BUnLDfWeK86YtE/1wE6zZxn9jbC8zHmr
         w8R4Ag0vrNn4jtgeVP3n1vmMgI/5miM2QkJlKmNSOcCRWerRhFBLtsC8kQoWtg2Ewr8a
         qzHA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1TxxXGL2M74UkIIpLlRcZRhVZwAjTzS+aaAf2f/By0UWwGbH3E29kQ4SFkbUkc5/nKA3GLB+UTu/x/N8Wxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxNE8h5MQ9B7kot+9Fb9Bo7BDifkiOb9AHARbeh0MgZh3fGaGH2
	mxjCBlqC8SWWZoGFr9yCa32zG1/j/UUZM7Td4awnnOIgyVETQkYeB8Io
X-Gm-Gg: AfdE7ckvK6vCVLfcY8fUm1l26KGfbR8Cb1+hrwj+n8SyhoNDmRgDi2ol0H7/XcPIrDJ
	DF7nxKVejc9gCENJepMLRd/Mju82wNu0i+cVNoRgZOe2v/fiKE8+XRhEQKACFGKeDPBLO3k7B43
	84elsuNmsSNJEZxpriP8Pb6qmJXzbTo9KHSpn6Au18SnyXpMg+8SAqSZQfg7C2xjIkEwQZdewtq
	6WvBYS+ZFAzDKeIs+006X1WD8DRap1OY1LTO02+M86EVN1UDrrgqvKOu3QYBCJ2RHbihCK5772q
	lVQ+AM/bY1u5Qv7Lmw5C8Sbmqdk1AQRlv0jcCoVpy79L7dP+ujcWGTxpdg05rtTMFKqvhegQl1G
	QPhzpHKTnjQlWrD2LZS/j2I6fbu8DYbki5fQ7OqJ6q5u5Zotzy2ykY5X/N/w/aUJbfEjoAeTlRp
	3IsPGbqmYkZHqC+chAqtNbiw==
X-Received: by 2002:a05:600c:a42:b0:493:c77c:108a with SMTP id 5b1f17b1804b1-493f883c8ffmr70582755e9.36.1783891056739;
        Sun, 12 Jul 2026 14:17:36 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb6f3c42sm307923765e9.1.2026.07.12.14.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:17:36 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush work
Date: Sun, 12 Jul 2026 18:17:34 -0300
Message-ID: <alQEbpfo7mHHkIcx@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <ag3Jh-8iUdgKvw5y@localhost.localdomain>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-2-leobras.c@gmail.com> <20260520134832.WS7TrMnu@linutronix.de> <ag3Jh-8iUdgKvw5y@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 04:47:35PM +0200, Frederic Weisbecker wrote:
> Le Wed, May 20, 2026 at 03:48:32PM +0200, Sebastian Andrzej Siewior a écrit :
> > How likely is it, that you you had users before late_initcall()? Also
> > can it happen that one of them uses one function to lock and the other
> > unlock in this brief window? There is no check if this was used before
> > static_branch usage.
> 
> Or let alone initialization on the wrong member of the union.

Right!

> 
> -- 
> Frederic Weisbecker
> SUSE Labs
