Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613F745629C
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786544824; cv=none; b=PTfmcAxM115XNuDgzWS9Ph9OwdNfTJiVtStum+6mvSdTak7V13mDq1Vh74FKE7DPLp9/ywhXoIahPQKOJJsF212juAFEmWYzhmgjLRVGanYV/6a9nlpxw1hlSGvCsyGJx9p6J9m385X5b2Un6QMeBwLdENUyS+KP1LKg2pCCluw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786544824; c=relaxed/simple;
	bh=WlxY3wKIIciSK5xxJfmy8JG1Ui2W6Ke5GnD2nFInhFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IfRJ73t5eh9uPE0smUgI4g5xXwOzBycwWeN6VRJNnG/9/g2AAxHQxC4iBpxOoI3v+m2BH0oVNx2EGk7eDaCrhfuZ1AQ+AEm2cZP4kRXYrOVGcIYYTu4xZyqQONxurUK6zyNut1KkTEa1Myf4MhWuuEnuTEIMZJhbyEb+rErXb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jAo0n24b; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jAo0n24b"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8edda5d56a5so10104056d6.3
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 07:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786544821; x=1787149621; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WlxY3wKIIciSK5xxJfmy8JG1Ui2W6Ke5GnD2nFInhFM=;
        b=jAo0n24beIHZaiiWiCa0RieGL8fpqfRRjdJt3bW0CkKrx0a8uSJWdeki7ML9fBIw6F
         yEiztXdg8R2GiOHb5rydWp8m10n75UbRbsT38elN0jiNMnx47DS0Iu4c7F0EdqpVBqwH
         nWT3ryvGHrFB1ZAwf3W1WL+n0EwHrE041aghZKVl8/LWVLNdbGuoEccuog1wPjsSGvc5
         x2sKSiq4sjlxpqsl3OtSylySrxPmNZ5JhhsmEvS4yXiyTG+nZ3dTQoQjxPKdG4lyIhob
         EvIyHv+bGjs6uC1O9yKrzJiq7CLcPzkMTt8fIMvapGsz66eign3SAsceqh8PiVtlxQ0w
         wR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786544821; x=1787149621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WlxY3wKIIciSK5xxJfmy8JG1Ui2W6Ke5GnD2nFInhFM=;
        b=chGY6idesDsiZv/N3rmQ5yUBIR4BGJ6lcWWknDEmfwk6sHUjA1RkrhFcfWifXE5pWZ
         Cndk/QVfKjzALC1IpNf03DuaiQDYcOFZ1Tm0duEd076rzSE+Va0sPdI2flvtB4g3FBJy
         hk8tqft/o0GND2dohuEGpovJwCXau4UScpXZ6qqzE/frfcRDoFuBMMdkZyBNP/KrXK6G
         5JEOb4td/h6Apvc7srihDTaiIirLbruAmiGAsTZ6L122mQTyGQHqAhQ9IegPf1k2P3TC
         O9ec9yQugYnMWd5BxYFlR6ykKa9zNpQ4lq7DybNp4SaOdnnv4wHsoF6xKC6bbFJpIzDV
         Fd2A==
X-Forwarded-Encrypted: i=1; AHgh+RqyuqoSVX2mlT4WjvZdvgbwQNI0A7jsTjAI9ohVJDM2iK2sRQ2bZZbbEWUmAW3cEcvZuY6byJP62F0CQT6teg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6LUOAZkeHOxP6IaFGNB1G/CYN1/14cS3+pe6syQW7tT3L4mkn
	1vJfXJNjDUU969vxpXiOkcM1+VGQUTNOQsHgIPInsT58zlBcmP0JzXuLErIiBdJuFoI=
X-Gm-Gg: AR+sD11nuET2X/SrQrTidEAfds/IItRwpd+V/fWDcwOiJIB0BH3p8YaJOSgOyVxxRGl
	FufW5aVYdpMnbjDfTxNe2iAkFwauqr4zLX0J9dVufgRsU2nIIB1EbHn09LPL9eFe8zJ5AP1j9ng
	JtVqgNdYyRkpII2XWGg63oKbF4YB1pIPCF/asJEn38ExCh4wL9CFQ2vx3IG4PoSWDDZ/FEpTKCo
	/CI70B1FQ5wsadKRJry4CtHw2//u47lIg/L8Y2jRtGTlZh/ap/4UITqHrrRaKZI4gfmJw5DUFht
	7xWC+8aFilvfwDTvWx5PtOxI83HDd7Dcf2RbjtIicrJRxdVLc9JjtEPk85JHIiUDsnzjaMJDxsR
	UL/t6aFIH4BuFXkaTxoTC9c2WMUNp0kQwKnsBND5U7qJoV9D/7DfO6tl1/GYaG4CRlsGKvtsRWv
	aFbFumoAyRH6lvYcF6wOi3VDfz2BOTuTsK5gUkBrmJtLM=
X-Received: by 2002:a05:622a:1349:b0:527:809c:f9cf with SMTP id d75a77b69052e-52d647ed01dmr43708531cf.21.1786544821147;
        Wed, 12 Aug 2026 07:27:01 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d61c08e92sm19033711cf.1.2026.08.12.07.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:27:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu9v1-000000036gU-37I5;
	Wed, 12 Aug 2026 11:26:59 -0300
Date: Wed, 12 Aug 2026 11:26:59 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-mm@kvack.org,
	kvm@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: Remove non_block_start/end() from
 notifier invocation
Message-ID: <20260812142659.GD662699@ziepe.ca>
References: <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
 <20260812122759.GA662699@ziepe.ca>
 <c41c52f02f033ea980d4b5f9b8239d5e9411a03c.camel@infradead.org>
 <20260812134934.GC662699@ziepe.ca>
 <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a48e6e7063122b22a8083bb0792984a204f316e6.camel@infradead.org>

On Wed, Aug 12, 2026 at 03:05:43PM +0100, David Woodhouse wrote:
> the non_block_{start,end} guards around the MMU notifiers, which are
> basically never being called anyway and don't actually seem to protect
> against any real bugs.

If you think this blocked stuff is dead code then lets remove it, but
I'm pretty sure it is called and I remember seeing bug reports about
it being triggered in the wild. Vetter certainly added it because
their tests were actually triggering and they had bugs in their DRM
stack directly connected to this.

It might not trigger for your hypervisor case but we aren't here just
to make only kvm work now are we?

Jason
