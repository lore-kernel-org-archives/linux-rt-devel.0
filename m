Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C936D4FC
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550705; cv=none; b=VEIsj+y90bCD2+my4ZglFMjE3Jbg/g34FXsInrjgKi2ZAV8ULOP3PLjCyQBmz2O6Dx+sg9HhbYJ+MZ5c98+06uPwEPaCe59G8V181Tjou96G3B6izHK1WzdozCVWukH6bcOkVAPeb1UScNThNaCPI9b7FolTMYvz9hq3xmAvDGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550705; c=relaxed/simple;
	bh=KNvFYWPxYeka6RYVhSJtPG0o9VDuxxFMEgnpnDdSwQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dJwfOTH0aMuQjFSEKnFbUllFYGYuR5ni/yHVyC9pCjUiUUKVkVS47uFgh/dN379iLjE6qpClIr8QqxMyHwS14FNtBpcZprqh1/HPy3E8B7nNJkUF+shmGP43FZzuLBHtdtEQuj6fWRhyd3kpqqAkL7mXNFyDEHX1JRjzr0Rk88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC8Jezdq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC8Jezdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786550703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVrpa6t08jfvsuIkBMY48klo1RAJTpG8dCB8zk4ETDc=;
	b=DC8Jezdq4PkP6HkogEomrBLDzQTw8rjlG8gxSU6I5c6wRKEe2N//YJIfVpBw9JP6wNng83
	ONP7OV858OU8k2DfBjTCqf54yfY/QrrGNcdi8kTAKwTDwG/beSBPEyOyaNNiVVB8juhxeb
	L3B5DMf/y5SpK2Devl9Uet79EmBn3zY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-d_qFm7UyNpaQ8uPmw2_Uww-1; Wed, 12 Aug 2026 12:05:01 -0400
X-MC-Unique: d_qFm7UyNpaQ8uPmw2_Uww-1
X-Mimecast-MFC-AGG-ID: d_qFm7UyNpaQ8uPmw2_Uww_1786550700
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47fe85684b9so894580f8f.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 09:05:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786550700; x=1787155500;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XVrpa6t08jfvsuIkBMY48klo1RAJTpG8dCB8zk4ETDc=;
        b=e2WjEZOpo56DpD+SMXUvJcnkJa24+Fy49b5w/BjCIkwHuouz9Pcu4lmJx2xcxnli+Q
         h/5aOGDwuTI20e+VmEUdOd0L42CnHatYFSffcwD+gfNusqgJTx5+Z4sG5x1uBuOb8FET
         d08UzDh7WA0gwjOtzv0D1KZBvmn9pXt6fJExoBIoeGnSI+dl0IjL2phyX8Qg7Nbrq4x/
         cpSLE/WCrL8htCkGEb1Eo4uYsPKyVDTibGRLhmIjhhSVe+zOPjeyIPPoDEe1infutUYj
         yDLT9sVEtDNodPw6mexmuWPnKr5oPKH9F31kvwwJM4OAXK+uMVD1Mub8J4BkHPItANEV
         nT5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rru8C74BajeK81WM+ttC4ip5m0+IrHze2Q9tg7rp6X+XdxOIradrfoJgRrptlgwWu9RBxPcuPq5+mGmmwbZMg==@lists.linux.dev
X-Gm-Message-State: AOJu0YznWLX/seQYYduQH7vKjCh3spksTo4lV3oTOc4pKVprwQ0LJkYF
	BrpyQEPs5zah92Vmz0aSrYIPDPeuE2yuerY1SqsBqCr+5PQVRSQtbgyXsYvLAHeRUEVA3+H7s8V
	rGcTeG1U3ImXTHOEERqgk7eEd4S2JEyNkH9SPQKgo9yYP0lcxJsNKyBj9aSW1EL6wEUFA1XsLC6
	Rguuw+BCsoPBKyzOLaFrtjBbcYSy2Wd69wCT9Oyftfx3o=
X-Gm-Gg: AR+sD12q5b5FIpfhmMmQsEODTHQMeHJIWAdYFJiZFdkhUHN7dwNTaB6Fl3UlZoo2QGQ
	PkkUWgwh5PZBYQ74unZFhkw5hCA3gd2QtdnjJ8H7GRjuWtdKoIVSaHnnej3k+pAHxCo7y55FpiL
	ZICCWP0A8IMhlNmvkuNduJzAxFVza6gLSiEsAF5j5axl3KclO0dN1HiG45RqGM26yub5xSgifRU
	XmOvVTKbg/Cy1nVK/OOruya/YRyXRAgVkb8ZCWAMHgi
X-Received: by 2002:a05:6000:25ee:b0:47f:943a:45fa with SMTP id ffacd0b85a97d-48152b01a7dmr8831827f8f.29.1786550700439;
        Wed, 12 Aug 2026 09:05:00 -0700 (PDT)
X-Received: by 2002:a05:6000:25ee:b0:47f:943a:45fa with SMTP id
 ffacd0b85a97d-48152b01a7dmr8831732f8f.29.1786550700093; Wed, 12 Aug 2026
 09:05:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260811135537.GC544626@ziepe.ca> <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca> <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home> <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka> <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca> <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca> <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
 <fb87f673bf290cad133d113dbb0750a7752b9d30.camel@infradead.org> <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
In-Reply-To: <a94b75e8b9b1d2191f365c0f4275fd5082332df5.camel@infradead.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Aug 2026 18:04:47 +0200
X-Gm-Features: AUfX_mxYjj1lPDXZPmp8aW6GUhdMuK_6ly_mDoPX9KEz7UGbw_A0i1e76HlJ2LU
Message-ID: <CABgObfYjdQ13Gd9AH-kck85ZWch7j_E00rajawFuRdt5D=m3Sg@mail.gmail.com>
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
To: David Woodhouse <dwmw2@infradead.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Simona Vetter <simona.vetter@ffwll.ch>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Sean Christopherson <seanjc@google.com>, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bEOlTwBPklfUrkJgu9KqyTZOGGp2M1djPGO1ImvN150_1786550700
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"

> + * Atomic-flavor readers run with preemption disabled, so every
> + * read-side critical section is bounded and running (not blocked) on
> + * some CPU, which is what makes spinning here sane: the wait is
> + * bounded by the longest such section. No index flip and no
> + * grace-period sequence update occur, so concurrent call_srcu(),
> + * synchronize_srcu() and srcu_barrier() are entirely unaffected.

Making synchronize_srcu_atomic() spin in CONFIG_PREEMPT_RT is a
slightly tall request - it's basically putting it on the same level as
raw_spinlock. But if the MMU notifier guys really want to make OOM
notifiers atomic, this would be basically the only way to do so.

If instead it's okay to remove nonblock_start/end under
CONFIG_PREEMPT_RT, for RT kernels I'd rather avoid
preempt_disable/enable and only make synchronize_srcu_atomic() try to
skip the index flip:

   if (!try_synchronize_srcu(ssp))
      synchronize_srcu_expedited(ssp);

Paolo

