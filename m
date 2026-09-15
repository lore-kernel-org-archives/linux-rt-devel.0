Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B9470428
	for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 09:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789464248; cv=none; b=JeyNZzFXgQx9FZdI2pmvYjwxWUYwee1b1Q7FmUfhyEaxjhZQmP8HPWaCL3Rect11pHhTntfTaZUsqXOKCRSTqGWN33w/ZCSnDRaI4jutXHjRD7i0oqHPP0/MGBcQi+UOM6wXLDYwvymUdUAZrL0VtN3T1312u+KXmcMIuAvorVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789464248; c=relaxed/simple;
	bh=Xbm7hC2sIniT4/hXQr3ANkVc+vI1px3ZGag7Yl7bcss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIsDcaPM6HGcbVNJ/JqsUUTIbZ2iKW7j23nZ+575FNxYrajpyJf1gkvQKJqI9SeMFhGKQhzA2EAyXGw/BihkHHxNg0Yr5G9wjMhaVbdZ4Nee9GwWmobP7SSaQAbzrd+gpvMfFc5XYrQgNuO9tx4XRYB0+wqjhGoB20eATOn2Xao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wq4rGI3R; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wq4rGI3R"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912e2406so12226855e9.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 15 Sep 2026 02:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789464244; x=1790069044; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aLdhT2Q1x0+krLh05Drnda1oX9PUv34jY/LmETe5rwQ=;
        b=Wq4rGI3RHukFzAELXl/QUQ5AojzFhOfq/eVC60oJzhVlZC/nzMHZpvUVe2Y1joW5F6
         cg4DWMnrndqlEEw9tHD0nz/GcXWYW7nJ7jWqNi2jUXGVrKmldCu1vlRahRTEWMjnE6ym
         Yx/8XupwDVG7Mw6zedIEyRzDL+WkkSN72aKoTZupAwv9E1dLkqo/+8ZL/ZYnNb7HoAhy
         jxADNqzct7FiunPsRh2g7vcH2VxUN9rKp0X+4jSMnrDVrzGaSrR+tYLWfXeeL6Cfyinc
         jI9/1zYmyjZX9Z8pAjspzg4Hg0CBLK9j43PViN/+iTw5yC3NY/jvZ16gqDsUsQ5xG6AM
         21zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789464244; x=1790069044;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aLdhT2Q1x0+krLh05Drnda1oX9PUv34jY/LmETe5rwQ=;
        b=0fD5qwMbtggECxP3h+CFiBHb7raBaD3iWYw/Ppnm9ODhnfeL+qR1Hekg8B/XKLh16G
         knHMo411KRTl8sK7hXsDr4tpGwD81gSHPGXKQyb3QWfCG8Bf77YZHXLp/36PXpeQT4Fx
         hunJ3MHkru+n19TK3OEtPtap0VSShxVyrljxtsyV0lvkNFJvGIlCsQ/U0Rv6gIoPHNX9
         Gnc4FXuep0c+iofwvFcQnrnf1CC+SykSlrvb7FPDzAuWFqL3KRa1yuj/Q/6N3KKgIUqt
         SZHabLN16ceBizMiPMOjr2H6LRGWV66QNaxReHT4VuruHM/AXXdujzl3OsViOyehJzqh
         ZySw==
X-Forwarded-Encrypted: i=1; AKwUvBxyO6cwsG1El2+UArO3cqS9CKFYa0wUxd/VGHAjxNanSPE+E8ogRNPg18nones5B+uwaf1XLRClx+ojjmju+A==@lists.linux.dev
X-Gm-Message-State: AFuF++nk+H51rZjN9IY3ykGCo1Yh6D+P7Q4/e5/2FSvVXco48gj77L/L
	5rQEMVbQ27XwsfxerOb9jTF5k9aW4HWnKrqrPQz3OWKWR1AKZWA2wo1f
X-Gm-Gg: AYBFou3G7jUaoi7iOCiy3+tUks8QlxNS8FejUxhqpqS7rkuf22p1BwKTWI3JD+phxsQ
	8WNNx0K/OdtojLVNrIbNURWcsY2IgQE3p8g+CLwUBhyQYAxgmEka1DqngzJ3ZujzdC1C0hu/4Qz
	tHFS9xjAcmC4ZHrgeoOsBNJf1DjU6cLoIXLivJYHASe/Yfww3ZSxUTnNWAkuo6DvWxaOxEDhptR
	+LvNa/O40p2V6gSc0uybe59z9EG2uCe1iW6TEKqO0QBeSykkgH/puZbEChoiRanwsgmjxdLrUSB
	VmZuIGdBGE1iGhfvJZu32R4OgV9UCb1wKERKevFoSTKQp8HuSNOoReVXIXpll87dHUANW3cFQlJ
	r9YvSLs+IomdHg6oh0rs9Ybf0TRvm6O+Jpbt2gnz2cJKL+N0gfd81muTQHAaM+SB2JdQsHkhApL
	gCVpl30q7KmLRGGFdh8037Q4+xH3DPEjdp0m0o7SFWprkKzF0Tu9YjT+p9pBaFcsxZUQa2aejus
	NF2rCgO9DPKzw3Lrbhmc+GAliWV+xOs3l4e
X-Received: by 2002:a05:600c:c162:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49e7d72b000mr36925425e9.5.1789464243970;
        Tue, 15 Sep 2026 02:24:03 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef9228fsm49333445e9.15.2026.09.15.02.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:24:03 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:24:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <ynorov@nvidia.com>, "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthew Wilcox
 <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@redhat.com>, Will Deacon <will@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Waiman Long <longman@redhat.com>, Dennis Zhou
 <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter
 <cl@gentwo.org>, "Paul E. McKenney" <paulmck@kernel.org>, Frederic
 Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, Josh
 Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Onur =?UTF-8?B?w5Z6a2Fu?=
 <work@onurozkan.dev>, Kees Cook <kees@kernel.org>, Joel Granados
 <joel.granados@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Mike Rapoport <rppt@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil
 Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato
 <pfalcato@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowangio@gmail.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, rcu@vger.kernel.org,
 virtualization@lists.linux.dev, linux-rt-devel@lists.linux.dev,
 llvm@lists.linux.dev, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 00/17] Treewide: enforce static storage for object
 initializers
Message-ID: <20260915102401.3c56aa95@pumpkin>
In-Reply-To: <20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
References: <20260915030336.1192299-1-ynorov@nvidia.com>
	<20260914231418.b15ec01f7225cf460f6e515a@linux-foundation.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Sep 2026 23:14:18 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 14 Sep 2026 23:03:18 -0400 Yury Norov <ynorov@nvidia.com> wrote:
> 
> > Declaration macros that statically initialize embedded locks require static
> > storage when lockdep is enabled. Automatic objects must use runtime
> > initialization so lockdep receives a persistent class key.
> > 
> > For automatic local objects, lockdep cannot use the lock address as a persistent
> > class key and reports "INFO: trying to register non-static key" before disabling
> > itself.  
> 
> So why haven't we been buried in reports about this warning coming out?
> 

Are there any code changes outside of testing?

David
