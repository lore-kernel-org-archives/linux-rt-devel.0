Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F72351C14
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353594; cv=none; b=diXg+xgFi+mh7lMBcwB8LQ9qHR/vJDIZPo2bx/tbbjY89CET4eSgQh8aTc7F1FYaLVuBEAv7/Qk2o9W+CDD53X5bJfwS6ISlRZUvlbagsZ7XECl5LRnM92HDZkeW11G0KUEWgdLDQuc+uINVAc2FkvLo7BZlR5HmT0AAcLgKFgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353594; c=relaxed/simple;
	bh=bmcgmqSoIAG660NAk9RAaAgXzOjnzTzDFCbtRpPIEz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jh2HcfCuaLq7CR+8oNO0fLOIoXZE6L4Dc+Un1c1iEWurTtOBGZiGtqGtW0O1FQDrSOoq30f9Nx9RfMDyCh7PM+/tzxorNuMfeHXhXAVfoBSjHUH3Oa7MEZScuog+RoJozP4pPnEfLqGYlWcewdwmCR5hMDP7Ymmu7ntf56sMwv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/yttBTF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/yttBTF"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e6db3ff7eso30103355e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 01:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779353590; x=1779958390; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NLFMm/iBCeKuifSA9r1fgWxDtRtuFPgfT6+/MU5KPl4=;
        b=M/yttBTF+ZS811w77aG1vk5WzC6fv6IYdPvsNfQT10rrxSxdPJg5C9eeWkpydvo5y6
         hCdBn6GOMcC9EiyE7a3N92kbz+nR1O6gVMTq1HQznFYz1m41BOfZIJRVXOvAr40cgA52
         IDOYD13AzhuC9Sg3WvStvU/qlsYjdAai96dzrSXquvJ/wpZGzAQwdPn851t8W8MMqStT
         q6o8cKmH4+vEEqRLmTIeiLNtMLd0dqw23GjYLtGmHy/UagpLvrdlEgaW2jvH8mf9DKXX
         eeb0dGadXYCX48Vocn6Twd1o/nUc8tyNtletDGSNiORcsHiZs/0h5RmbXARGVDf4P8Ze
         vq7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779353590; x=1779958390;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NLFMm/iBCeKuifSA9r1fgWxDtRtuFPgfT6+/MU5KPl4=;
        b=Xhkyea/WnBpyogPNI2XVVeU3a3XgFc6NgQAYtAGiSOAFvLiF+w4JdahdUpiI4R5vOG
         q0wIywdS/K4u8ID+4V/v0xD26lP7R3inB++afzfuAtwi/6hC9ZnKl6d8LrSlDic9lt5C
         Xo29DO7vFxDIkbOmhcmMNp3npuA6O9dJUQTyjUUf+Miggw7wOACWWy2iHeEue2lqQBTy
         eSEcg7Wqm9CzA4eJHOuNigcssZTw5Z6lfRocXkXsr5uIGG541yyfbNyebZu+y/46aEKI
         pDizfGavgsVna9JX8yU/vt5AQxeCdWzo1r+nPxm1lak9w5hqdq1pAtNs34io84hWwhCZ
         gfYA==
X-Forwarded-Encrypted: i=1; AFNElJ8G3LoALFjYfZPjJGn90ISt/WXcVJvODYKQ3rTZDx3hkBdcN6YC461UaYx0azCr327XUEPwzE5PBhOIhS/L9w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwA9fxMLbROTU3MuMojf++AEEZZYDLmkspQAUD9C/s6AypJs2Dx
	dK328d7+cb8vZk0bVdUOKAe7rPazL1akbagbXl+8kkbCvqDh1jm2LIpk
X-Gm-Gg: Acq92OHYHN0qzChH+Pv35ShOxMP8nH4j+L/qyNSMMzyvYS+ELrtuww+Yv+HaxFxlHeL
	8r/R+DvOpD/ZxrPwNod0MOJmXhF/tM1WKewcESIbJ19FcfPLGe/brZRH+Y8vEzZXcT2qQY0xpnd
	R6BavxGFkGgFE7coSMGnizOQjiOhM9UzYwus6gxFget4Gt08aOivOn2EJAXyc6QqMkHcXHliEYz
	4HlC9zpcP2nBZh3UI+TZvTTaA8ATIAK1okiwcDYTYT3FPAblWCW6LKEQ7MKJg2xI2KI4L+IRBuH
	1d2s4Priikao4eW8gEnIVvJyhgG0iYTUxdh8fY3gj2dAIOr6kNhWfMLoRE0P6tDxJktH5bPz4Ie
	tg0gtW4NBQh0dJZCxoRei26iNBaCGcaGABa+Lry4q6RLEEqmdj1B8R2WppnrREwa5Ylz7NFvKe4
	CYqI/1kzZiHNL+hrPlVJQRWjcUk0eFsp/5eNxQ2YZAFpVImjFlSDJRUXz6KPMgtyKo4biuYjk=
X-Received: by 2002:a05:600c:548e:b0:490:2238:4021 with SMTP id 5b1f17b1804b1-4903605ab10mr26339485e9.8.1779353590237;
        Thu, 21 May 2026 01:53:10 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49035ef2d93sm14280335e9.9.2026.05.21.01.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:53:09 -0700 (PDT)
Date: Thu, 21 May 2026 10:53:03 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Bert Karwatzki <spasswolf@web.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
Message-ID: <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
References: <20260520225245.2962-1-spasswolf@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260520225245.2962-1-spasswolf@web.de>

On Thu, May 21, 2026 at 12:52:44AM +0200, Bert Karwatzki wrote:
> Since version next-20260518 (with PREEMPT_RT) I noticed that my debian stable/trixie system
> would sometimes hang when booting displaying the following error message. After about ~1min
> booting continues to a rescue shell where I could save the dmesg output (The output shown 
> here is not from next-20260519 but from a step in the bisection).
> 
[..]
> So I reverted the this commit in next-20260519 (to get a clean revert I needed to
> revert commit
> 36b3306779ea ("fs: cache the string generated by reading /proc/filesystems") first.
> 
> $ git log --oneline
> c7321982a5d0 (HEAD -> rcu_critical_readside_bug) Revert "fs: RCU-ify filesystems list"
> 16ff8d6e7c28 Revert "fs: cache the string generated by reading /proc/filesystems"
> 6a50ba100ace (tag: next-20260519, origin/master, origin/HEAD, master) Add linux-next specific files for 20260519
> 
> With these reverts next-20260519 boots 30 times in a row without error, so
> it appears that commit dc651e25a6d2 ("fs: RCU-ify filesystems list") causing the
> error.
> 

I think the patch below will do the trick.

If someone wonders how come the missing unlocks: the original patch had
them in place, but when I was rebasing on top of the RCU-ifing commit I
figured I'm going to do guard/scoped_guard in there as well. Later it
started failing as the compiler did not like goto retry out of a scoped
guard area and the unlocks did not come back.

tl;dr there is definitely my bug here and it is most likely *the* bug

Christian, can you fold this in please.

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..8f17c0abbc95 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(void)
         * Did someone beat us to it?
         */
        if (old && old->gen == file_systems_gen) {
+               spin_unlock(&file_systems_lock);
                kfree(new);
                return 0;
        }
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(void)
         * Did the list change in the meantime?
         */
        if (gen != file_systems_gen) {
+               spin_unlock(&file_systems_lock);
                kfree(new);
                goto retry;
        }


