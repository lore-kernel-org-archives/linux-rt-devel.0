Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B6424D73
	for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 12:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786537684; cv=none; b=QfVx1Qt9tKsFlugG0okNtcb4H7M/nZW/DoGiqOldmk1bVBjUA7EfPWtBuidy6LbUcAXrYaiVXyPgBP+abwLd7SNnD6bztZ+659gRw85uUuWxhbDq+SHzlc0Vpwt+cREn0D3wUnd368Uzdv1akDd4z3Oe2/HUR89IiVYKovL5rdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786537684; c=relaxed/simple;
	bh=OLsQWQAZ8OxYrzOAjJrunSXzJbHmrpka58K+pH4v6TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S77VrMY5hlEi6biOdvkvl6Y0Y7zcpsSfm60v6Sq5cHKY/pJ8onHtNWh2hQyD28ps3DoCD6Ipm0mQD0C1UrVhk9Jj0WsWhLbAZyEUpNoziApJfQq2EzpLG9znGqfmjbOSp5iuofxuIrZ/gD+iJv99Y4rJ/BlTUalXNfEtx0sAChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Hs1tY5G5; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hs1tY5G5"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c04bf4711so9476031cf.2
        for <linux-rt-devel@lists.linux.dev>; Wed, 12 Aug 2026 05:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786537681; x=1787142481; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nO3QhHY842VdcusB6Ch/Vqg2F2nPYU3R/4exE5xwEVo=;
        b=Hs1tY5G5LB/aIM+v216upIoIH8wMBDiDo1ZbbfAvZYyZkgCyz0E6w4HcHK9iRXG4wU
         PSz4/p5BOc8sz3mId0PXHfTrmD6E5T6yq1Apqkf1XKk9rjn6h/VS4feNEQpdItk8g/MW
         btD659ScHERlhRZvXJY9N+ADdUJBSfHJg4AN0Q8IKMsgbrWb1aIgsMa0XJIRNkL6VtVd
         uORcpboWj62KyPWOXQ/8PyyuLgcMXNzd0AqAZXFbjrMB4I29u1HsQDt3T7GAsyHVHDt0
         Hcqqrm9v7+xnKRvl5fx9vMs3gdxWDsJcW8jSSlDeLgSVsiPTuPHpojdvxwS/K/V2LIJw
         80wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786537681; x=1787142481;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nO3QhHY842VdcusB6Ch/Vqg2F2nPYU3R/4exE5xwEVo=;
        b=ckwfzxlMILKhERNNqBjOjDWXcOj+cuNhkkq5EBoIPJLs7jSfi3vS7ndkKJ2tHPcKKZ
         EurJ7YwyK6rH6/s2OE0oKD0OTDrrQG2QSgmH97ej8s0rM2yzaFDOorAc+u3tLs47h1mn
         sxKbZfAqKQEGvhiYbLX7kLN1jXdjx3ZAICl3Uaupy7ajiVEN7ozaABp80tNVTqQCMf3K
         8iiXncHC7if+e1pvAQIwhB0LDOCjB5UEvnXwcmYjSjEX6qluSO9FZcTfSduwCzeXRpam
         XcCuVEZTwq/OsDsaP2eIsSos5aNgwrc+DCN6bSrlQ9RXCUTMWPCQFCA6LbooKPrk2gK3
         tYMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr0bGMs9Exx/6F3BIDjOckWENON61XVKw4XuRS94zYfSYsFsG31obzKlzetpmB16Lb3MVSYfoxiDWfu+PjhUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzvBMo7leifdM8/1Ffd41Fw/W8NyuCOgIr07m3MuIEDXCdwdY2r
	QtiFkFrLkvNUYCsGEpOByZUCXPTUMTMxVR53DqHw+2G2lMIJ/p7gINhwUUBLz9jXMME=
X-Gm-Gg: AR+sD10L7YWk92bdZTKe42ojDNkiMwiQ4Hp6bGtVLkiw8pv3VPljoKyKdRHr5X+zNiQ
	hxI8tvpHDR87fwVTDM927hXtPXHZ3PRrsHwcqj2KUd16QVRtJtmzxSQ1/9l94gqZd/AWX/lz31K
	z97lWk1E9fFCOAZzSAV2lS9TxGxM6sKViMblwVywD5JJPpmleQM8hym97MxTMTCw7bIDE4aiPVY
	3zlGf1+9RXrY9UddqDsLv7mApV8PyGnhSlbqtp0/WnVNktJG363KHlQAX/I3wRstqHD3NdaT+9v
	7bOoLcTTW5K2lYxQWdIK7gmoHKqXU7S02YoPLoXJdCWTHhx2UAOfs+I/5UmwBxNSU8wouPMcw7p
	f+Slt84ASznMkrMXAbiwURX64AO/Sf1QI6Ub1Dwm86DDjS5Ml1+T5Xtt7850bAxH14+ZH2akZZJ
	ikOACN2yRFysB22as05W8HYGt9yK1Xamgf5GNSNM2fazIvGHaj
X-Received: by 2002:a05:622a:2596:b0:517:7188:c47a with SMTP id d75a77b69052e-52d646b8da0mr38269131cf.2.1786537681291;
        Wed, 12 Aug 2026 05:28:01 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c29e942sm20435386d6.12.2026.08.12.05.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 05:28:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wu83r-000000030Kg-2xlk;
	Wed, 12 Aug 2026 09:27:59 -0300
Date: Wed, 12 Aug 2026 09:27:59 -0300
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
Message-ID: <20260812122759.GA662699@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
 <anwraNIKJV8zwrNT@tiehlicka>
 <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44c51ace9b0dc44b795f6f48c91cda440eed910b.camel@infradead.org>

On Wed, Aug 12, 2026 at 09:21:31AM +0100, David Woodhouse wrote:
> On Wed, 2026-08-12 at 10:14 +0200, Michal Hocko wrote:
> > On Tue 11-08-26 16:24:48, David Woodhouse wrote:
> > [...]
> > > I had a second reason for disabling the overzealous check too: to allow
> > > SRCU grace periods within the notifier callbacks.
> > 
> > Is there a way that srcu barrier could cause an indirect dependency on
> > memory allocation? In other words what might block the scru to complete?
> 
> Not after https://lore.kernel.org/all/6eed3fe3461e9690b486ca98fa7563f60d3940ff.camel@infradead.org/

The user of the SRCU might have a read side that wraps an allocate. In
general it is not safe.

I'm skeptical that without special API and documentation the KVM
special use of SRCU you've outlined will not remain working long term
too..

Jason
