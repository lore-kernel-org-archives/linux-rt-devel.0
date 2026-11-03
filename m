Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719026;
	b=2vjiXb2v99Q/hW3qtIovidbrYc/qsMPDtCytUn0Wcssr9NB67RMbaVlCGY/dAhX4DqRp
	 /RbuPB8tpbpB/oUtrPbxQmtuyFAg6yvCxrJG++LgSf/DxXg3QXfH/MUg7UNRkVZ58fdLj
	 mngPxO1L5GB5skVhjeIgX6EUTsy9PrkagcXeOH0j2bMkCteAY3QXbcQS3tQCbUM1yJJCc
	 v8gmSojONTBbl2q/E+j/VGRBUjIo/0HxYKfDhgZHRuFhjYcJvkNf4xZ2TzPWoO91kIvvj
	 IsRODgybCX3DeBWE83ViKuQ1JoiQtmq/63pSoKAJBb900GGS90J4QON/SvQ3uQnTw+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719026;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=gZPyGNb7zpjaaj961jv5er4Nb77WoHldzauRxys7WyE=;
	b=4GfztwgUHShoZMqz5UO8dGTkul8KP2/CKEE2qnr2NeZHFOQFuHJvKcN71rKzpsyGkm9g
	 ADLc5V89smDMoNJRlGknBmBKBZ8dUG73qwnTsMJF1lHsarZhNnodLBRYDPs/9pD6EY1G/
	 Xq31/6e45v/h7hgcYBLL3OQvAfs8BGju/BUI9MhMQWjYZYTAcolDU36U7RXBtezEgyIhj
	 e+QyRmFrGmxmcXJpELmbQGAbdzi5dcXy+1wJbvysh1aBol+DKc1I+yh7s8RqK8T7rKnUW
	 5CXAt9b/4s7D3qT/1eZ7jwMTaAcK6Qas5JGscv2cv8pCBp7SA9A7HA/Yo5FavCo0uGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GemeLBV2;
	arc=none smtp.remote-ip=209.85.214.197
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9C8606D2F8
	for <linux-rt-devel@lists.linux.dev>; Tue,  3 Nov 2026 15:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB9C8606D2F8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GemeLBV2
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2e9d52f684fso42299685ad.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 03 Nov 2026 07:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793719025; x=1794323825; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gZPyGNb7zpjaaj961jv5er4Nb77WoHldzauRxys7WyE=;
        b=GemeLBV2bK4zdIXfrSBlVm4i2GtblOK7PkEYT26GmxbmBtNa28thV+QRUp7ENgwIC6
         FKk5r4R28KC6vZyS7UId3+w34egIaH1OP827i9Y78hWaszOh5qXWAhKJ2TEMAe0PDpih
         Zf01hTDzqFOqRTz14EnM4d+lEJhGQNcDAHNvlkOCCVssJvdp+MsABFOyl0+6yhmBzTy2
         TFP1l2TNnATvcz8uYMQMzk8anyZzWr7Au2x5AnSd3+TBHHKKQ5mwClFT1y1E91LsSBEj
         oLLxUYBr8lyS7bi9UdjBv7+4P2V+WmNMDWD0kfzdVd1jKr8VJvrah9qnialCtEB4a2GW
         6ZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719025; x=1794323825;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gZPyGNb7zpjaaj961jv5er4Nb77WoHldzauRxys7WyE=;
        b=zRQhAxelioIjYPU1ubT/owtJg6ZbracA0mXJ+xp1KGNBu5ZHca5t7jYPseRYnPiig+
         cKOYg1lOc3V4+E9hg93bxFRs7iPGTB+QF43S88vq90H4GnD/f5Iy4z6N4ZFeplt/ajgT
         M64hws0J35UNEgTjhnrNl5J5sUleGxRF9gZjNJXLa1tSWosAnET1FFDwy0bUXSsmkcmj
         DbZDKv92m4KM2V2SKZ1E9IkBWIOtrtojzwqgvXVBMyzu1fL2SMNtNw0rwgMUwN123dYM
         CdAGNqjiUdfJXWR5v3C4cRp6WWe/TQiPn/wEO8oDyaDFQ7VJjVONa5Li8NEJxlg6Gjq4
         YRsw==
X-Forwarded-Encrypted: i=1; AKwUvBy3aCFj7xou4yhbbYynzYobHEbQfWaaLujvxwwy1IJkDHybOS3KK3OeOHA1Xrys0uMdhCt1stkgHYD9ic+gAQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z8qplC+e+qrk7VV29iEepnP/sa2Sy9EEz8HnloXJr0UIFfAmvhD
	b3AzNyueCVGAXktotPnZ1VQQbx1g/w6xVLB88APAqH61/RqAgOn69w/cJUkM+8M0d2fCzZ96v0w
	AOSe7Ww==
X-Received: from plsr11.prod.google.com ([2002:a17:902:be0b:b0:2ea:d63d:f2c5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:22c3:b0:2e5:334f:f47e
 with SMTP id d9443c01a7336-2eb36489c9bmr122626395ad.21.1793719024883; Tue, 03
 Nov 2026 07:17:04 -0800 (PST)
Date: Tue, 3 Nov 2026 07:17:04 -0800
In-Reply-To: <CABgObfZ9mHj7Fsq7Z2S5vFy8R2Gkh2tHBATGJN2BpH=6Waks9w@mail.gmail.com>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <6adf2939.67317f00.38c4bc.00ae.GAE@google.com> <20261026224305.1254-1-hdanton@sina.com>
 <auCucDdZb8mig7UZ@google.com> <auDvUyfzg6nLtVox@thinkstation>
 <20261027163929.2bb28d5b@gandalf.local.home> <aujLx1FOc12E72rF@google.com> <CABgObfZ9mHj7Fsq7Z2S5vFy8R2Gkh2tHBATGJN2BpH=6Waks9w@mail.gmail.com>
Message-ID: <aun68Iv_z6Xiz9mc@google.com>
Subject: Re: [syzbot] [kvm?] WARNING: locking bug in __refill_objects_node
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Harry Yoo <harry@kernel.org>, 
	Hillf Danton <hdanton@sina.com>, Boqun Feng <boqun@kernel.org>, 
	syzbot <syzbot+f11512d1e5878ba5e60e@syzkaller.appspotmail.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, 
	Vlastimil Babka <vbabka@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>, 
	Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2026, Paolo Bonzini wrote:
> On Mon, Nov 2, 2026 at 6:43=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > > If so, we need to make that a thread for RT kernels if you want to ca=
ll
> > > kzalloc_obj().
> >
> > Eww.  I can't imagine there's a sane usecase for memory overcommitting =
a real-time
> > guest.
>=20
> While I agree with the feeling, the dummy allocation path should be
> mostly dead, because page fault should never (?) enable interrupts
> before waiting:
>=20
> #PF interrupt gate
>   exc_page_fault()
>     kvm_handle_async_pf()
>       __kvm_handle_async_pf()
>         irqentry_enter()
>         kvm_async_pf_task_wait_schedule()
>           kvm_async_pf_queue_task() <- registers waiter
>           prepare_to_swait_exclusive()
>           local_irq_enable()
>=20
> The dummy allocation path is only reachable if it's an L1 hypervisor
> that is getting an async page fault while L2 is running, because it
> enables irq before the call to kvm_async_pf_task_wait_schedule(). I
> think we can drop the dummy allocation for good, which would be even
> better.

+1, I completely forgot what this code is doing (although that implies I ev=
er
knew in the first place...).

> Whether you would still want to disable APF for RT kernels is up to you.

Nah, on second thought there are use cases for async #PF other than memory
overcommit.  Whether or not they coincide with PREEMPT_RT is debatable, but=
 I
don't think it makes sense to go looking for trouble.
