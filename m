Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795655070;
	b=MZ1TljOL2jys28kgPwIckOBPbKHbMRgik9NPXHUtCWIcQ+sRR7izvR8EaS3LgZzpFqRA
	 EMIMkfDynVHKvq4LhuDRV8zfZVLiUg/jsQ3hV/VQu6q4cSfLCpfw1Jv1NRvQ1+1V+Sv1V
	 OSSrtV6lDjgOJQ03/hoB2+mVRhx3U6Jo/eyGoerPiEeduaBUdSS8pKTUkUSosSt/U4GmE
	 2S/PzPXYPQUImgGkpcScbxH2Z8bngJLnR6mKOAEWasmt9/NrFTZO3hEPLXzzY71LqITiA
	 XR9F6IvTltG8YDgkGUU8KHBJ1uPU5ZI0jvP7Di6AhcDcBhM3YSFkhxLM37wZ+0rPOiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795655070;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=KIktabnjHCDieeGWMO0z9Hmbrz6ngvKHiYWHyOgAZAA=;
	b=l8ZsgwcWOUDvGIu5E0Hz/zZ3Su9zKX4TUCtbrPWXTkWQZLl/ZWZ1Z+yuAjpp5/1f/MvH
	 jRIMSdxoe+tTr/+v7P8uwlVLi4UmVF3uoaP3ikJIgl7QW224kTNV9OMZetCFinOFRgOoG
	 KDDNUE3/E7NMpysLGYNWqVidH827msuYPTjrERO72neGRevCWl+wn++u++/YxTeBKzSed
	 XMQQbDf0hok43sAftA7wb6HX3q6PtWanyuW20IWsIE8APTEELQDGSX0Q+UoO/F+qq3zUR
	 5fKWBi27P5NxVI+TLNgg2iWr8vPbz0qwvpTFbGilJEPEOf+ycETp7lNMartyK+e7BgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLW3KpCy;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6605606A31E
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Nov 2026 01:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6605606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLW3KpCy
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso3264921a91.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 25 Nov 2026 17:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795655069; x=1796259869; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KIktabnjHCDieeGWMO0z9Hmbrz6ngvKHiYWHyOgAZAA=;
        b=XLW3KpCytnWTpb6qvq4n1CT59VlHqBmMJx8VHHBh1Zr3JjmIHDyBojoKMfijrXUP/P
         tyyyDBK1GlDNwdil8rjHAL+75RIK0SRp61uLShriKzb7+nVo8qq6PxaRXyciOOCn4jO+
         BI3/fyzxeOXLthIIb8GW7Cc0ZEyzX/gYa1QmW1C8H4y8sYjRRk/XrYgKEWKOKccTOaZ5
         Ny+duTU7n9aWkEFLZSHWxYw14VedifgUCBJt1QHNBsJS5sjvvcGSgQOxehrSiky4CE2p
         tmem/S3X+88dMLGe9gyOJ/rL2HisQYJKatFdFxmBJ/Xp1aAwCbXOt94gATeqZAAtN8T4
         q55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795655069; x=1796259869;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KIktabnjHCDieeGWMO0z9Hmbrz6ngvKHiYWHyOgAZAA=;
        b=yhQ0gYvvy9t3yujMYtwF+0XJi+Jcg/hgxyStuWm76umyqSuMzNGgjtlA6PEJ3Ey3ZH
         iw2dcKvW+j3PPx1Ts4dD4speAkJUib3eZBgt+O73R7b7jMVbcjWJgHMIpDwRorpcyR0g
         PKk0X50XqIEERdME+XDWNSxW7F7DAPOemHvu34fbLzpCtMQoZN844SBPw7EdjoXGmTV/
         R5qsX4qYyDDe7B4f/5ez5f+i+DLQfCbPos3NT7SZ+gav+/qvW6IiwjPHE9qZJA0JlP6A
         jtE1zeqqwBGxNU9NVM7Z7yaXpupbQXp7nOqDzOZP+9KUBcUZ4EeN0q0fCluyduBu3RR6
         yVNQ==
X-Forwarded-Encrypted: i=1; AL+hErFX46b2L5Q5wz2NGWWk6CjR/R9rJCtdRx+/YnHFAjIdbyOZe6Q0YjZILKKL+9iMmutwKkpUjxj338KGNliHQw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Tt8otEC0Rrr3leGwwoLhlIt7GLhxXHSS+qT+0ujc0p/SmaMKc
	V+NLXIHW9hXEwmEijaMgzG5ljhXuhtfTSpQq2aPSGbJzVBS6HvnAyajg
X-Gm-Gg: AZFdTZfdB9UcVP6ffi4NnArptAocOzP1zKMMRtevB5FZ59DZEbHCaSATd7WRhf8qtRh
	98y8Tv9/AYrhv+FOlctQMNyyIBuV2sT3WmU/LvgBt61yrXdA/y5x+uhHDUgBIXIswB8BCGLA3Pz
	aU+mXrP4sOt8PPUcPHyl2aZ3wELjWJNwDPrH3kdaNYFUIRTq47MMWB6MVr1kKsGuDZQwqK3YNEu
	LVe33kCYbg4De+D9KO8PUaMdxHfzxohC+c8nFR8TozcGgYugStSHeKvt5Oy30qhckCmxdm1vpfF
	rABgZNnmBKgYUdX9j5GTqLv+9kgxCB2k6jzO5hVPrww1Pvly1QCP8v6+jV3V6ED+5J/txmpCd7X
	Fir5pHtJe8svmvBcfxUbzk2XqBqW+QSfb40e/N2VCcqtqyceN++3uKUM/9l+/chCHPH5knhCNAq
	m8yCc6sH3Y6K/ev34sPAYteab+N9qylWAgBQtiUbWHe7AoJYB1aogAYVRHbf3HBtLX3TAvNosLZ
	vMK1LzSTR9BLfvrUCzAMh2fA9f23txou5VPGDUhxQCYB+0EApJGOibJO83R4+wBuyTYgayk1BvA
	aNlKSRsOI/dxi7cUtObQ2p6rkfVVO0iNySnHUCceGvCaAk3XyhA8Fg9QwAaoH1qws4zGvraa5zn
	1hO2T2gjY1OY7KNyPGYH0eENyYq6P6a5ONg==
X-Received: by 2002:a17:90b:268f:b0:3b3:a421:7e00 with SMTP id 98e67ed59e1d1-3b41c8d4831mr17552841a91.16.1795655068912;
        Wed, 25 Nov 2026 17:04:28 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad92c07sm30289984a91.13.2026.11.25.17.04.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 17:04:28 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 01:04:27 +0000
Message-Id: <DN4QLI2XAGO1.2DDIFJ49PNRPS@gmail.com>
Cc: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, "Sebastian Andrzej Siewior"
 <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>, "Steven
 Rostedt" <rostedt@goodmis.org>, <linux-rt-devel@lists.linux.dev>,
 "Vlastimil Babka" <vbabka@kernel.org>, "Hao Li" <hao.li@linux.dev>, "Andrew
 Morton" <akpm@linux-foundation.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Brendan Jackman"
 <brendan.jackman@linux.dev>, "Johannes Weiner" <hannes@cmpxchg.org>, "Zi
 Yan" <ziy@nvidia.com>, <linux-mm@kvack.org>, "David Hildenbrand"
 <david@kernel.org>, "Ingo Molnar" <mingo@redhat.com>, "Will Deacon"
 <will@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Waiman Long"
 <longman@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v1 1/4] bpf: Add call for selecting kmalloc or
 kmalloc_nolock at call time
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Peter Zijlstra" <peterz@infradead.org>, "Harry Yoo" <harry@kernel.org>
In-Reply-To: <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
References: <20261124060357.11700-1-emil@etsalapatis.com> <20261124060357.11700-2-emil@etsalapatis.com> <DN38HGVL8JHQ.2ZVZQCKFXVA9T@gmail.com> <awWRZ9xCzWLnj_R6@thinkstation> <20261125140902.GE2668804@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 25, 2026 at 06:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
> This is absolute atrocious shite. You cannot attempt a spin_trylock from
> NMI context. That thing might be a mutex.

cannot spin_trylock from NMI _on PREEMPT_RT_ ... correct.
And the patch guard against that.

On RT the nolock path doesn't reach zone->lock in NMI or hardirq:

  __alloc_frozen_pages_noprof()     alloc_flags has ALLOC_NOLOCK
    alloc_nolock_allowed()
      can_spin_trylock()
        if (IS_ENABLED(CONFIG_PREEMPT_RT) && (in_nmi() || in_hardirq()))
                return false;

fwiw kmalloc_nolock() has the same check.

> This should not work; if it does, that is an accident we need to fix.

It's not an accident.
In NMI only !RT SMP kernels reach the trylock.

