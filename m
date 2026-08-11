Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1281395ADD
	for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462238; cv=none; b=T444U2fUTZhu0x5WEpgnhZy0EGm2m44Ql1KOzO6FcFL9hgw9xhu0ajAr4JgN+/eERrNoJ8tZd55DkzJh6UvaUjvB9BK4FGvzpSrqVPn/CFqUaHYJy9CQOg4ti/yMwK2lnDrnBfe183LDg+E2QYa8GOa40GKdgqJqfE0PwlZfGgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462238; c=relaxed/simple;
	bh=ajdewnx/cyhu5yu7KfoSulJ0n0owi6YVHKYNKTf+Sz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fynbma6dhCjjgw3t3egw+9Rx0hY196SnJ085uQdeFvg2OPjE8RYrSPVp3gQr0mljEQwzB08jIjrWCTuF9NvfQ17Xne83v2PfEb3swufVg60ldEP8cGROTcy5EEqVeMT/tCHyineVHs5PVd+ZtTXSD/t7uY49PyVyVkq9QCg4LrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=XIIA1lnK; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="XIIA1lnK"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8f29ec73064so18007776d6.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 11 Aug 2026 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786462236; x=1787067036; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HZ5oPQk870n4i5Wo5FTt731WhaBz04ce9fYdf/2ufqM=;
        b=XIIA1lnKHhtMyTYB8hPdnsMBfuymG6O40+lIjsuGys97LnMzbLICKnqbmhEk8zFNGE
         UdZH7sOTm2+mzRiu5MlPk9U4H+8XFhTrDx2E6xan0TXfYS8rjRyOMwaUU8HcLm45z4Ao
         gO9Twk7JuSuK7LR10fw2UCNjycdb5TDrIRayHSZmN4GOL0u+0fia2F+A5Dyf4P9Ev2Ab
         g5QzDJlZluoTc/KeWNtnnzfIAUMM9IWvFbkCIsBbJOwGUawkFPiXrF8xijNrc8jVngqB
         6mOJYqf1nuBw16s/DVGs5irNQrBxlu6xppdLGNV13WGn4OL6pFRdXM5sbBitVwFDcapp
         eHJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786462236; x=1787067036;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HZ5oPQk870n4i5Wo5FTt731WhaBz04ce9fYdf/2ufqM=;
        b=ZSv0y+w+oIuHsRWfkjxBKzIHrCXCiuaOoXjzggRMgDk2/uRHKMjUpe7FXmPmcFVOfh
         IT8C2qZfsZFTbqkZS/9J/cslurmVEKu6YiOYxRUQjWJQjnemK0F9lVAi05Cz2jgJmJ+2
         8K7p44HQxxBJ2ozXemNk/3+ApP7QWwtxxK5YoxNwm1+DPO/zMtHUJCZ69FeAYkcjsdB8
         sIgcN3wMYkTY222wqn6hfo8Okajo3DbZZ7j4Ro0R6LCqGds51P6iWy4to8RgjgUrhN2n
         DvRCZcpulP98LtjbF22385paxcsJ5vK1WDTOXY3EHrpAezyUU75B0AzmZcP7QJyO+Xvd
         n+mg==
X-Forwarded-Encrypted: i=1; AHgh+Rqka1449GX9Nhq7aJrrtEdhfZWMKi0cM64k8HaW0JKdEKBGqFUKKjMFCB/1eXnPDexaAVuTnQkx9o0aaG8kMg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz/JLrUvCQWwJamv6VdszqKodMbhS9gUC/lxyhBjUEyZfkeeDdT
	9yg+HTYfNaDfq0brF2MicXm/82g1mLA3jElcwJ8B48qIsK6DlUd0+/pHrDQsRu8R96c=
X-Gm-Gg: AR+sD13jyO6GRA6yaiNatxGJ4a6xgJqNSXE/Dkxt1mVnLx7veyJtJQS0GtZqZF8R7vm
	O2Z7ZU3Q1b7+QVm12yhAH5Hf5txoFjmBaROG+TB/Za+EmH99BpkF93BFOANRP+zwb2Oj2YMFBTP
	IRf5X/YVGeFPPONbculxyPGLfRgf6K6/iDFRZB7jW7G2YSBx12bzVY4A7i7VVVaWR9ydW7Om6zZ
	nxPFsWjxleF6JQNmt2NpJxmrK7OJVDG1aC79HUuxXGFRENddmEyAwT9DM/RpdCqqNJpSvBzFE1j
	TNW2BBBHG4ZXt2k9+O2vi+bJCU2iI3GhgWFr2NFFIdIw/mW6Q8epAVE8I6WRhVzdZ4sgKfSQWjO
	JtrTQVnXTkwA4dTQC67pjY7cTpsk+srnnrqjmV5a84qZwUC1Nge5H33Gh3Eummgns/AVZj7VT9H
	O/7RkqrN9EBnkcu2Ax5wzm60wEfGGqWgXF/NtQkg==
X-Received: by 2002:a05:6214:2aa3:b0:8f0:c170:4591 with SMTP id 6a1803df08f44-90a667e886cmr37546616d6.4.1786462235465;
        Tue, 11 Aug 2026 08:30:35 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c2a05f3sm1600106d6.18.2026.08.11.08.30.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 08:30:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtoQy-00000002X83-0m35;
	Tue, 11 Aug 2026 12:30:32 -0300
Date: Tue, 11 Aug 2026 12:30:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
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
Message-ID: <20260811153032.GJ544626@ziepe.ca>
References: <a247c49dd61af1df7ddc4dcb1cccbcb36b04d9d5.camel@infradead.org>
 <20260811135537.GC544626@ziepe.ca>
 <1d669aca4ffee797b9c29215382444a5b23624b3.camel@infradead.org>
 <20260811142730.GG544626@ziepe.ca>
 <a552b227e18ddbb3fa1f2edf2d1cb30ee6ccff13.camel@infradead.org>
 <20260811104229.72fdd928@gandalf.local.home>
 <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37b83b429b9f14ea6ad4ca1c13cc8e565ec09033.camel@infradead.org>

On Tue, Aug 11, 2026 at 04:24:48PM +0100, David Woodhouse wrote:

> I had a second reason for disabling the overzealous check too: to allow
> SRCU grace periods within the notifier callbacks.

Don't agree with allowing this at all.
 
> > Thus, perhaps something like this:
> > 
> >  		if (ops->invalidate_range_start) {
> >  			int _ret;
> >  
> > 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> > 				non_block_start();
> >  			_ret = ops->invalidate_range_start(subscription, range);
> > 			if (!IS_ENABLED(CONFIG_PREEMPT_RT) && !mmu_notifier_range_blockable(range))
> > 				non_block_end();
> > 
> > ?

This seems fine to me

> Or put it in a per-mmu-notifier-ops flag (a bit like the one in commit
> 5ff7091f5a2c, but with almost opposite semantics), and let the drivers
> Jason cares about still keep the guard, while KVM doesn't need to. With
> or without the RT part...

Nope, common API semantics please.

Jason
