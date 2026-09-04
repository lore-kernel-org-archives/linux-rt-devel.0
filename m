Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB15509F13
	for <linux-rt-devel@lists.linux.dev>; Fri,  4 Sep 2026 16:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788540322; cv=none; b=a//6S+IjfZv244un8fzEVIssNRAK2V/tN+kSYNBgjT5AIDaOdyl98rbX5ZuwIHXWvWaErbRsYTjMBRgzHmJCeVL7x0A/mb1b1FlrSmqrISu+wkLYtDqqfAqG8Cxzpz1FKeEutXrEOoIfI0/NHjAh9q/8SapNBhsA1QIb4cV77R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788540322; c=relaxed/simple;
	bh=LbKIi03ISeCz+kO0+SjDUGksD4whdOS1e3Afuc4ZIvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgykknoXDRQId2cy+kgo09VZRi8HXwtasFH3I4ACA3g+IFxVvjpzbii7gk27r2lMBg5d+7fe4uMvBghxY0Dno6mKwdNMBoRPqz28mp4C7nqIIzOPOtSM+AP5eY53FXXBSNe+YCeLq/4UhB8KbiGyzelxdqWHFIUEBJBVIDnuslE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cu4z7dqp; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cu4z7dqp"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so11460905e9.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 04 Sep 2026 09:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788540319; x=1789145119; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yah4I9qe1gWdvzoT8BPLgON6ATUn577HEvNphRVkQcA=;
        b=cu4z7dqpIVTdpc0f5yvNuSoWDPkdT2zerzHNIVNKvSHrgJZBz9CBpPXGj8cjnVKCB+
         0Vk7qdDfzNtG6yHAWox3+F+X9lZqyJVshbNvLv18Wj3IwkNL3zr7WJWHzK6DIZjon4c/
         bfdh0aB5TJNpJq3hrfxrKLAFUeqid9dGMP84gThWvBDwYImVg2/Mmh7Qo4qFBrrm/ZDL
         +n19AKuhomjtT12LJydupWEPvkmVt+bq+388OHKL4QSx5wsGV9aSwaXDcJEk3gUXXw6w
         9s3VMJm6Fk3BCezayiPtWk/Zq/a3H6JbOIEl5zjushc/bFyBiHGnQVyA78OyZRTY3Xu+
         1nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788540319; x=1789145119;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yah4I9qe1gWdvzoT8BPLgON6ATUn577HEvNphRVkQcA=;
        b=bomSvTVNFCkHr5E+Fa062GJUsUmfULkP/YGqPUwbhCRuIyx0A71Hk6S4TBedYr2qRW
         DbfsQDPDLnsT7muiBgPcKvTXQLrjwxDBVF/S8pJ9x9YG8Ygg2hh2GzfBrnu7S1s3MQ33
         D8OlqVVzqAr+evASnZm0h7xKxvB5QUetlIe0Mg/tNPXzey77EY9+l+qPTncUvQmBnChZ
         DUmLwSwX8mylghX3u5gqs79dnwcDjSvJb/s/VmbvNKvpfJfO5dHbvjHttmyTF8PPEqrE
         0LsJSVReOhOckAty3JPsxvVHKIRXmkpokriONWTpkZjH97KG2ZewpWI+Dg8aiXe+KaHn
         Rtpg==
X-Forwarded-Encrypted: i=1; AKwUvBzfNmox4OFzp4jerPYFpi7MvxxRb3bN+bF7+1cUYQUqnteiuO4Yhu8mzjd/C/Kj/2n9Ataqhf9OUt6jvagrCA==@lists.linux.dev
X-Gm-Message-State: AFuF++lJs7HSFPv1hJtgPI/keCcntComod/SN1QC3EeA+/Flu1H5OEmw
	+EV+ySkJ+lYuWapsxtcnjncJrLNVWkCCIioj5rx5tEZlYRYOSj5vyvPj
X-Gm-Gg: AYBFou0fe8SQWzlnbCEbjH+UZytOu5a5NYkTad/p0fv6otMDVKMA7Pz27aPnorvz9H8
	TXNS3HJp6MW3nsC9mWsIl3nS/NE9wpBjDA+PoLLRyjEc/4G5yqDzdsfHsPnH3nWgy5uIKMZjuoy
	+hjBfMroafCfqSY8BaPItl+PQaAxUfJmnIV9qb6lINEgPjHM4BPGebyOKeZ1VKxwIYA+KgrNpzH
	/926Cvwlv2JPj1x88lMDmdmCt8VfWrOiGTvwjuJsTg0kBrbAFtIFYcecZIZVbjkjUG6zOjVq7Ve
	hD/hqrhcpcFQASti6OLx/tanBNyMuhry4/YRxSTPIa89+GgNTEncObcZcp323rdl3HeJgfufhLw
	pEhbu9o3g9aRB2xPN58hw2O/a+upiX/kkWfOLVPbNzCM8wIuQFtUn095jj5vfjjhhdzyXpHbthG
	cDZxJat7mM6PkTXe2q4SD7uHzuzpEBY3l9U5DMp3ooOp+fJuKRR0TyCd8iFfVdgkXZjRh2ZjDsD
	rN0njvS1zbiwhtMf4tqN2MJ/AuHx7hv51fdwWx9vbwWCfRsKxgDLDGESRd0fGiBGMrSZJfFUumq
	UArtOeN+WiHQcPxc3SWpPTeH5PnW1GzNN/hZH0H//OCnlz4dz9i+q4BENVFNREOYCpF3dbkDqBL
	F
X-Received: by 2002:a05:600c:474c:b0:49c:f4e1:4c2d with SMTP id 5b1f17b1804b1-49cf828cd70mr68770285e9.16.1788540318646;
        Fri, 04 Sep 2026 09:45:18 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-a4f2-6901-14a0-23ad-a35e-aa8c.310.pool.telefonica.de. [2a02:3100:a4f2:6901:14a0:23ad:a35e:aa8c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm182752585e9.13.2026.09.04.09.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 09:45:18 -0700 (PDT)
Date: Fri, 4 Sep 2026 18:45:16 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Boqun Feng <boqun@kernel.org>, Lyude Paul <lyude@redhat.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Alexander Potapenko <glider@google.com>, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] softirq: Preserve interrupt context during IRQ exit
Message-ID: <apr1aTzIZmQPZbQG@gmail.com>
References: <20260903112737.49551-1-kmehltretter@gmail.com>
 <apmQrTzP0sTSReI1@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apmQrTzP0sTSReI1@localhost.localdomain>

On Thu, Sep 03, 2026 at 05:22:21PM +0100, Frederic Weisbecker wrote:
> > +	if (softirq_count() == SOFTIRQ_OFFSET)
> 
> Any other value should be forbidden here.
> It should just warn.

> > +
> > +	if (softirq_count() == SOFTIRQ_OFFSET)
> > +		lockdep_softirqs_on(_RET_IP_);
> 
> Same here, you should warn if softirq_count() != SOFTIRQ_OFFSET
> 

Good point! I'll send a v2.

Thanks,
Karl
