Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F50D4E66CA
	for <linux-rt-devel@lists.linux.dev>; Thu,  3 Sep 2026 15:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788450234; cv=none; b=fQZ6euZdp8tXouAXiU8ujTKL9846AX5tRUb6pHZNX3wyKAF5fHnDfz6hrtUw8TjQuCFrTGWxfupA1EfLYpJAqFpsvsodZt4Kdtl81/qlqPDRQ4EsH3kRUJKUyCaJsPXE/vXAc/YIfS3Uk88y9xd/4bNOpxyyuTrIBCYL5WhzxFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788450234; c=relaxed/simple;
	bh=Cr1VOzuxeE4VILI2hx+ruBgQnAyfzuEw4v1Ifg8gbxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOTofvu919l6gkwnhHlA/TCeZct2aNHhvtWEPS8CSbkKJ8wwWnUGaQvRoawU0ldxZ3L8uHdhD03dv6X4IRRcAUcNjxs1v/jodqAI4ZUumtBMNqa85muZUdqzEYyhP6/gJB8OSFQ6gSAFBdEQdZ+1bVh9hINpVmqziJ0gFJptNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS40AJRF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS40AJRF"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c255acff671so372662766b.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 03 Sep 2026 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788450231; x=1789055031; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sGknXrZQcrgiQ0N899uoAGQuTMFJK6yez7o9faoOnD0=;
        b=kS40AJRF2E4U0Z1E8w3zYgWgakcaP1PYMr0PmOEqdJ3tn0Zc80k7RedlGh1SRQN55f
         41LYnHvYtymh3XbYwVTZiXhEVYdVuAEBnB2jG1i46dOAHLIp15GgkmnEPAjACZxtwusJ
         8xxH4yCzp5SH7cq8xcdIG0L98AiPCYEYhC7ZkqcwL3gVh4yKeRcm565aDtV1K7gXFNi4
         4p+6xcQ8KxEftMp/NoWBldQkbmR7ID+EXbdb7h7lmrW6PkrCp0KWdfv/FlDUoiNq1o3j
         zCBEd4X9LKVlhJkY6StfpL6VT5TXmQC9GE/FndU3hIB/6edHvaVrdvNJYRvJEyUJWkMh
         XliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788450231; x=1789055031;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sGknXrZQcrgiQ0N899uoAGQuTMFJK6yez7o9faoOnD0=;
        b=JoVVxcVTJqgLr6DvKBBIpwq4ETpNplbZ4Pq7Jw3uVfRx24lfE8YECz34D4aLaFrZLD
         rGgRGkgIlnD/kMjLTAJflkEL2YgNTt0C831IUEtEwMxLM9T6GE7E3m2pyIx9ZXddGwqX
         blzX9LXG6o/0lPL7UqDdGhOfLujynHT1WWVpz/JOAPY/aQyGunC4A2F6IUIfKMf6z7BL
         NQheY8Kqrg82ihQox37P23e7L/XuZweEB1TH5EObSg/fhut5zhgHaIxDGeMcxsWAU5pa
         LA5SYOCcKU8PUTWwGh3iUhOnjffkAqOYE81bmKcRjU+DdwphN4tSaHew3tIOxLxO2L1n
         jRhg==
X-Forwarded-Encrypted: i=1; AKwUvBw/FkzQM/W4W3eovJi1LGdCelQ4KFlUfylMh68onzAzpeBxl+zXmaOYI8EmrqlwTWBgvG5p7cwR/aGJAQ6DNA==@lists.linux.dev
X-Gm-Message-State: AFuF++nGba7t73F3E28ALIsEefeGvaHKN+HtaTr1OvEWDWuWix3q2cVi
	SzaIEmTz5JZf1nqWPW1DZRdJPvgrV849VM/u4bQBjOcpbvfpjblKcv9G
X-Gm-Gg: AYBFou36pw3mGuQpj071ZzQDF/leWO3bXpvSYCe7kx3uJ4O3corxUt2p1ZMKzvjdkse
	qlQxcwASOC6WnMRi9uoFaq5753ovgvY7arSuj2LL3GptlQbYoh5PvWxLCYv15P/7yhjJmeeiuxs
	8h7k3cGXIKWyt6JUU5d0g1PfPDzhiFnF6URJjN+Z1dshHfFNIwYB1ivTmXZDggtaVj2evEbTH89
	lXVAWInfL625Q6JuzqAFDNeDkmDOwDeHvjB7K8yt0PTXCM/DBTumqKgiQqpZ7PII/Qwchu7sL1+
	/Nczij4TBkziMP6cXsAY3MvTO5Aaw09WIC9Gi7rIidpQXblb3weAE+klj/C2Tte7HeznD5FBAMR
	tBn8D3us2Ey3plC1hV3JWIuvZpR6FHGjepp1EDkHiKkFZMi7Vw3p1tcIQXtW8UMipXyZEkJYtiV
	9Sp3UHKNLzoDi7XeFxRG6xm3VHqDuZusoDWJlluuzG3i0u/hK/jcRXTS9rJTiSDvczBjv7q5pkD
	uW/S7T10Oc89OUGZh093D20BbwunJZPlSnRd/qzA+mvcMd7/DTCZcojxessOPNo+KMheFHywmWi
	kqBcJakh2uZ5e5Lsmjrni3gqh10KlPoy91jSFDbH0TCEkdwF7XR+9X+FSNVGGf2dfp89J1yPjHQ
	cv10ae83arxLsg7QD
X-Received: by 2002:a17:907:72d2:b0:c25:6e17:9b4 with SMTP id a640c23a62f3a-c25d555448dmr878028966b.24.1788450230386;
        Thu, 03 Sep 2026 08:43:50 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25f4172032sm115066066b.22.2026.09.03.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:43:49 -0700 (PDT)
Date: Thu, 3 Sep 2026 17:43:47 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] softirq: Preserve interrupt context during IRQ exit
Message-ID: <apmVB5OtKkYEyskY@gmail.com>
References: <20260903112737.49551-1-kmehltretter@gmail.com>
 <20260903122017.ZRsTFeks@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903122017.ZRsTFeks@linutronix.de>

On Thu, Sep 03, 2026 at 02:20:17PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-09-03 13:27:37 [+0200], Karl Mehltretter wrote:
> > __irq_exit_rcu() drops HARDIRQ_OFFSET before deferred hrtimer rearm,
> > softirq dispatch, and timersd wakeup. This work is still on the IRQ
> > return path, but in_task() reports task context.
> 
> Is this new? I don't remember seeing this before.
> 
> Sebastian

irq_exit() dropped the hardirq count before invoking
softirqs in v2.6.12-rc2, the beginning of git history.

The newer additions to that window are the timersd wakeup added by
49a17639508c and the deferred hrtimer-rearm hook added by
7e641e52cf5f.

Thanks,
Karl
