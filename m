Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4801B481675
	for <linux-rt-devel@lists.linux.dev>; Thu, 13 Aug 2026 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629579; cv=none; b=Gl7JLzkqoxi8hajv+O+v1yXnt6220CrLu6rYbaMMPJbcjI5j3N9evAUB5i608AugmdecICrsfD9OugZJn+LQu6rBEcgq0KjuEix3QyRMahzS6HQxMCW5a9gu3USxjO+c308/E8Bt4ZNP3jm3cXVF2/A9IHuLwtw+xERk5sMKI1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629579; c=relaxed/simple;
	bh=Jcs6K+YlygMbTqlTpKMywOxSkiWRViSArY2ePaaIAWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GhAwmF4vHig02WEnShLtFTSc1hShaaN1CJpmxMgyyVHq4XHL7Z5pajpW0bxYJ+YbsHT6I3PlGUTGcPevfqwmmfRr8CWEJoG4hmTqbCfm5k/VvZnoM1/dErFso2H/s1bK+VWHS70K923JmeWzsnQx1qE/z1KYIPdFIv2qRuFRs2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eILdtSGX; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eILdtSGX"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cb11535e6a1so717879a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 13 Aug 2026 06:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786629577; x=1787234377; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Yp2r6l/p49Xe2R6+sIrvq42A9Bi9ttiTK9kJ5Xxsr58=;
        b=eILdtSGXp9PakdFxCxSsXz8/d1uL9LI4utgDh8BiAQsvUYCP/TWlv2JquLtSM/LT0u
         MO7eq24SJoZTWvVkgOy5/i7yfb7bJoa5c+9J6HVOmemzS3zq4lLg043tXtaue+Q7BfYd
         HMisHNJ11seEDK+/ZIzbREkv1NqhNEYDADMdHhxUci7nWBoaB2AUm10um4vF4XmoGEs/
         jzFY4LYR2mbF12hsNPHPvhtJn8WK8I3XGR6Zwr/uPAfgysKOSQTxwmaQpJUZC1Kcq8CY
         Y71L0DpVbwWRzhGGDZprU6sduQPj5ResVc6AvOvLLCEJ6ODfpPU8Vxy461jw+ZNq7po4
         eInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786629577; x=1787234377;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yp2r6l/p49Xe2R6+sIrvq42A9Bi9ttiTK9kJ5Xxsr58=;
        b=cQ//c87WHSFcxS5GnUjcwrymXWoyKpslDTLzsAPGWemyHNpyQ9knIG/GBARHfCNWNv
         gw1tI20pDzv/+9zTT+xQMd4cK0yTy9Ha2gE3u7G3DOrmUxD9N8f17Yihep1fP2/O8TLs
         YhaUipnObsfluKWk/liPs+H4ITws9NIhODtq3V6SKTpaPRQ+jjR0WvfMKlhCkKUJX7KH
         i89gZenQ4JCP8AU6xkU9oLR4p9NBKBHgHRrQpF+2KR0JkxYrwoEO1e2WJk8dCGzWP1Le
         G6VYCOE+5Xc0NIeOjntwWcoGAvsA5tp2kxWIvvEQXqPg5AIdQ3l0SsrNFHoRhDdS3WFM
         oj8g==
X-Forwarded-Encrypted: i=1; AHgh+RrwBZSwsrTQswwvdS0Lzsyb5yUUsU7tAroku3xK0TviHN8B4G1XccrEBuju+qRavt8KlBT8Upuah0oBRe0SUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YweiF6YN3qTzqnMcDFwvLRbB59T42Kcl56SEaqwznPXT9OOzLgr
	gOvZcXk0DWfbP1tA/dsJ8VC/qH6kzUcD0+gK69+fKy+7kfntHCW6IFtZ5Xht+gjerEbJQNzKwn+
	tt2gZfQ==
X-Received: from pgl8.prod.google.com ([2002:a63:b08:0:b0:c86:61a1:3390])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6017:b0:3c9:1c1f:f516
 with SMTP id adf61e73a8af0-3cc552c3825mr7736253637.19.1786629577230; Thu, 13
 Aug 2026 06:59:37 -0700 (PDT)
Date: Thu, 13 Aug 2026 06:59:36 -0700
In-Reply-To: <8ba4860fec45afeaa305bcb011d732ef0da302d6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka> <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca> <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca> <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <20260812142659.GD662699@ziepe.ca> <9e65be44430e7d013fedf9a1626caba020ad6d94.camel@infradead.org>
 <8ba4860fec45afeaa305bcb011d732ef0da302d6.camel@infradead.org>
Message-ID: <an3NyIYrdN3li0ag@google.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
From: Sean Christopherson <seanjc@google.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, 
	"=?utf-8?B?SsOpcsO0bWU=?= Glisse" <jglisse@redhat.com>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org, kvm@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026, David Woodhouse wrote:
> On Wed, 2026-08-12 at 15:38 +0100, David Woodhouse wrote:
> > On Wed, 2026-08-12 at 11:26 -0300, Jason Gunthorpe wrote:
> > > On Wed, Aug 12, 2026 at 03:05:43PM +0100, David Woodhouse wrote:
> > > > the non_block_{start,end} guards around the MMU notifiers, which ar=
e
> > > > basically never being called anyway and don't actually seem to prot=
ect
> > > > against any real bugs.
> > >=20
> > > If you think this blocked stuff is dead code then lets remove it, but
> > > I'm pretty sure it is called and I remember seeing bug reports about
> > > it being triggered in the wild. Vetter certainly added it because
> > > their tests were actually triggering and they had bugs in their DRM
> > > stack directly connected to this.
> > >=20
> > > It might not trigger for your hypervisor case but we aren't here just
> > > to make only kvm work now are we?
> >=20
> > I'm sure there can be real-world use cases where it can trigger, but
> > when I was *trying* to exercise the code path, to validate my belief
> > (from source inspection) that even the plain spinlock would trigger the
> > splat, I ended up having to hack the kernel to do so:
> >=20
> > https://lore.kernel.org/all/787aa26cf62dfd361eea8ed19f384fc517892501.ca=
mel@infradead.org/
> >=20
> > Perhaps in the past it was easier to trigger 'naturally'?
>=20
> I did a bit more digging. On the one hand, I was wrong to claim that it
> never triggers =E2=80=94 there *are* a handful of reports; of my searches=
 this
> was probably the most fruitful:
> https://lore.kernel.org/all/?q=3D%22non_block%3A+1%22
>=20
> On the other hand, they are basically *all* false positives from the
> point of view of what the check was actually trying to do. And in KVM.

FWIW, all of the KVM false positives are due to PREEMPT_RT turning mmu_lock=
 into
a sleepable lock on x86.  So killing off the restriction for PREEMPT_RT wou=
ld
"fix" the KVM issues.

> It's causing more issues than it fixes. Including some bizarre MM
> gymnastics: https://lore.kernel.org/all/amMZFqs1smKmMuj5@lucifer/
>=20
> At this point I don't think I even *care* whether we manage to do the
> atomic SRCU thing; I think this check should die *anyway*.
