Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130C2566EA
	for <linux-rt-devel@lists.linux.dev>; Wed,  9 Apr 2025 13:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744203898; cv=none; b=nfgethwwUDs1pcEZAqMadLpq79UjbF/yAEH0UaLW8cdyty65Qwv6CRGGACFgYn0P5u3K67dIqsrH7v73/xSrWEQW1Xgdl4kssdo0Bb36MJbjPu80MyCvB1mTJp9eNaVmuq3YqK8QJ2R3IHNIr9I3GCww9Yl4JmE2IWlBsFOedNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744203898; c=relaxed/simple;
	bh=366rSGqKDSaNaqnzuXgMVPDEcnVkkx0y3VLfHOXvzWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8AdsBBzl4xj/9ckwPH2MoL4RbA9zt35WQrKKqGMAYPEObcGx/xQS/iouKNd05xyoBXnxJVjkePjpt8NF9Hn61W5/QGCYb0Jgur0KkkMqLnuNhW1EaSKvm/ZJD4lEYjXxDpr6ghybCh9ikP26tjHN178fCxija1egGCg+CZUfwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCQx0sc8; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCQx0sc8"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfe574976so46347745e9.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 09 Apr 2025 06:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744203895; x=1744808695; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2cS0lrW0iOQVVCSI2Cp6NCF74CvixMtSANH/SVtlGds=;
        b=fCQx0sc8bUG8G14ljK+RAcPbTpONk3JOHlojmDdEBxW398IN7WzJI55EUohOphnylj
         Dr+k58pfoqf78ndq5LMnvT3NyEmX43F+7JFltPigdv73jWvC3prk2ElfMFLJkkKLa4aX
         dlZtj2yxU96vYxC8X79H5vJp8U5juPVt7GKZSlPao9upS5lLGiAo3P58VE1MCEUwlagq
         6gvc2i1q3ehX1FhNPP1+Gf5cJMa/5ESiSUmTXaoBXd6kvvtY2DfVPSgNMLG9w3ME07YM
         3FeGLDbo60Shvgn2zB2gtw3jB96IqxWwJyQ4JpmRHX+xepvnMSyLa/n9BmHPNKFe0n/Z
         rkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744203895; x=1744808695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cS0lrW0iOQVVCSI2Cp6NCF74CvixMtSANH/SVtlGds=;
        b=NbIcYZEEh6m3+EHc55HsW2uP+SnpMeXoKsFuqrrlJb9IT5ku4KxcD1QdM7Wgc0ktNI
         wbUpoWezDOE+ntl/XahStLcw11h5uuvnycGwr4eO9q49xhNi4kZSODaNDVWCCjABM9TB
         AiUTjAJGYXbz8o16BDVkBZso5ATqiC1U6TooWyE44oQryzn7X6IkWF36yyrWbX+K3O8T
         JDslVmP2KFUcQzRvtxzEFONGxmongQevy47MTZpiZeosf4SQ0YHBx1ludRT+9sNfviO+
         nf9utZWWxhq0hm0ZAtc4H+6O8SGCfUPNQVB8vlaQ89jiQAZlOgUelDVXPVUr83pe/WFC
         +Vtg==
X-Forwarded-Encrypted: i=1; AJvYcCWy/DhZtFZwUiS1BGJQ9uZjqCJjcTGn/7u8eMQ8xMNgJKk+11l9F9FFrGn0vgIqtGl1ctcRz1L4AnPSZvhJ3Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YwzvGcSYPFQLZCmZo+CDEAUHH4mwEo16GsrLAMvaK/sZrMRQxtV
	rsYPRRSFnfnEIcskoJr1xKYibul0qeLBie22DcX12oDm67/eW52F
X-Gm-Gg: ASbGncsWwTMTUSH1/Q+u2d1ZPl/nqg8Lvh55eTUROKEgUfVzyPz3UzCqETN1LCRabyU
	j7x8yre4kY4Obeedr1jAnK5BUY3b0wDfrpZxy/9bp/PKN7eidTFZFvI1tx5jECRVkgosMjq+l+O
	Owon+ZwjbQg1aBEm8gfXziQLW4KapT9ZM7vHTs3ZlLqfvEg5SwbKqJHKfq9+A+32i/joVKxHCQu
	iGrqYpTe+tJz51xbYWblAvmLU4/q0ka05d0naGBfrx1MiariCLJGaJsVg9Wi3p8z0/K1rXXDNlY
	WcWi+O6CWHUy//oLz4NFaAEzMnkVl7GKJdPKYk0DTloz8ctp4Ub/ZEGb
X-Google-Smtp-Source: AGHT+IHze8vgtp89EBfanMiJMagv6hp47UulZJ9+q1wuQnRxXIQjwicF431hKSZALOTX5DVhgOYcig==
X-Received: by 2002:a05:600c:1d86:b0:43d:7588:66a5 with SMTP id 5b1f17b1804b1-43f1ed671d7mr29495825e9.31.1744203894700;
        Wed, 09 Apr 2025 06:04:54 -0700 (PDT)
Received: from f (cst-prg-17-207.cust.vodafone.cz. [46.135.17.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aeaccsm19257355e9.33.2025.04.09.06.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 06:04:53 -0700 (PDT)
Date: Wed, 9 Apr 2025 15:04:43 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Ian Kent <ikent@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Alexander Larsson <alexl@redhat.com>, Lucas Karpinski <lkarpins@redhat.com>
Subject: Re: [PATCH v4] fs/namespace: defer RCU sync for MNT_DETACH umount
Message-ID: <mey7l4rm7r5fxndlg72jfjjwwctyoimjg35jetrnv5gbee4qll@w5ldyvm6h22a>
References: <20250408210350.749901-12-echanude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250408210350.749901-12-echanude@redhat.com>

On Tue, Apr 08, 2025 at 04:58:34PM -0400, Eric Chanudet wrote:
> Defer releasing the detached file-system when calling namespace_unlock()
> during a lazy umount to return faster.
> 
> When requesting MNT_DETACH, the caller does not expect the file-system
> to be shut down upon returning from the syscall. Calling
> synchronize_rcu_expedited() has a significant cost on RT kernel that
> defaults to rcupdate.rcu_normal_after_boot=1. Queue the detached struct
> mount in a separate list and put it on a workqueue to run post RCU
> grace-period.
> 
> w/o patch, 6.15-rc1 PREEMPT_RT:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>     0.02455 +- 0.00107 seconds time elapsed  ( +-  4.36% )
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>     0.02555 +- 0.00114 seconds time elapsed  ( +-  4.46% )
> 
> w/ patch, 6.15-rc1 PREEMPT_RT:
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount mnt
>     0.026311 +- 0.000869 seconds time elapsed  ( +-  3.30% )
> perf stat -r 10 --null --pre 'mount -t tmpfs tmpfs mnt' -- umount -l mnt
>     0.003194 +- 0.000160 seconds time elapsed  ( +-  5.01% )
> 

Christian wants the patch done differently and posted his diff, so I'm
not going to comment on it.

I do have some feedback about the commit message though.

In v1 it points out a real user which runs into it, while this one does
not. So I would rewrite this and put in bench results from the actual
consumer -- as it is one is left to wonder why patching up lazy unmount
is of any significance.

I had to look up what rcupdate.rcu_normal_after_boot=1 is. Docs claim it
makes everyone use normal grace-periods, which explains the difference.
But without that one is left to wonder if perhaps there is a perf bug in
RCU instead where this is taking longer than it should despite the
option. Thus I would also denote how the delay shows up.

v1 for reference:
> v1: https://lore.kernel.org/all/20230119205521.497401-1-echanude@redhat.com/
