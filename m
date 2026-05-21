Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7133F5A7
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779354556; cv=none; b=FfE6Fl1/33QVKGNAoaBThd1gH8nRRyw6gat7j8NvAee6ea3m9+pKDTjdrVD50yzjnLxAZmnv4scxMOIkzb1I0sqQ9cDKjIWIcnoA9Zxa0dwhxpsSWLp0g3I18T3u7GScLN7CvRZI92x0rOaKkjAI/rpm27SbhJKRg35Ub9Q6bH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779354556; c=relaxed/simple;
	bh=62AQbruIL8xoYE0iLxKmGGOuXzkPv/xXfeMgG0rWsAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cU+UgRWGkT9WoWukevkvkIDpdv2ZenlrFUi+Dc42yKcPI0iqrMuI/No1H3zwjo1awyjy5/sY+j/jopCaYaPqvDgezejvmWImNv//QsFLoHGxyz5hQ1W+8lKPxyBnPpZACcCeuLqjH9pjjSzKIKfoj+4ApsVmhTD4ph4/kTwg/+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hnXRq0nx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnXRq0nx"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so46853065e9.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 21 May 2026 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779354553; x=1779959353; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b8kZ2i7zbAXV5yShgKzVk4H5++8WU3pOXXmVGQ1GdXg=;
        b=hnXRq0nx06zXvLVWAqNq91jg4Q/hcV0JNjwkgp/J3DoMyCwScwmtUhHLpS1s1jSDFj
         nKvpR0PSn053r7Wkfrh2/SRDRvVsVhxpDE6IRS0JYQi1fUKV4MIpGqN2AmvARsVCqThp
         YsblbR+El9V02cGnznZ7hlxv9m3iFG/MIZwSW4SNQu8ZAQwpHChzarcKHFoaOAHQA26z
         bB+9+p71HwlRp+oBugOVwnzRrCDvjx9SA6cRpjJ5w1Wcce/QtBcGA0orEbL6Dvoyehv/
         cYzYg6IugOYNXR7EEd9gPEV6mmLoagXqKNT2X2z/L1gWphcrvaCrVYu+6Bfxj0TLRXiz
         nRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779354553; x=1779959353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b8kZ2i7zbAXV5yShgKzVk4H5++8WU3pOXXmVGQ1GdXg=;
        b=qoFmg4A0M0LZJVqVVgpfSkMVhWla4BaKJh3SeDQQ2rHm20HuS/+O6fBBuBr2X1CuFt
         WmZPaEEVOkA9PwW++Hn/f3ax750DJcCpM5uQXn6YdTkOmOM8x4W0uo31C7UzbH63co0H
         GFaZ6kyco1gP8FGMe+Oo+WcKSrEZQ+QC7rSBQscGnvFeLpIp4IjLrEAj3x7K+XDt/ZzT
         bqFDEg6FhsNvsB2F/UJkPg31bk6Vm6m2/fBBNmXHUdWTVTzq3UjOQxcoaafhsRF9Of3V
         f8x8v327/Df5FCKmUHDYV5BCJzI7bDsIVC29aXnROv0wn5SRXHw2QmLdJGow/n/rciL+
         HpNg==
X-Forwarded-Encrypted: i=1; AFNElJ+ahfc1SJmPKKsJGK3sWpFTJaw2u+xdh7TEN2l508EU6LOdptO5j6celE4xvARA/e2um1uhQQD+ScdbV8VhKA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzdDBbfqM71Y7tzOpQ6+40t7rZD+rp5QlHOqczedQw5PWgyQJpN
	LvC0QPumuPlvVhaNJuhEIhWtpfEjozuj4b9oBkJ63vG8O7+U7nko6V3w
X-Gm-Gg: Acq92OEZnuZsxTTcYvEzI01wSkRudUZ7a3U+rM5pTIp6gvD7Zgi1qYqjZDyDXOlER+Z
	A5isi4gMDocnNE7N4fvogSnQigpn8jTy0F7CWAEkkbDVjd0Hh15jztqXSIQKYHsQxJKVNGPTg74
	1+YhI4qDqRCWDEPS/qjiNGtK2OPrXmIJiNu8xo/1HWhuSgRBEBYZZuTNIFQAHxDvZpE4sButLKl
	1ue8AkmaKB5QF1mTr1sttJKBLhztnSuqnRu6ARTy1V5cHHSgzqoSKY+Hhvby8q1QhrvSJb8hqRs
	WDZ26FwYI9fRwSazVwIovxXQO99MT54QaW6tBdmC0vCXVEnv7IRJb1yTGRo0WuYBwaeLe3pQ7Ok
	rCD95JalqB6VGg7kefM+8Fp087tXkEfQQhqQfshdZMu1GxoWWIFeR6hkigoyMCuKOvflVCtzToj
	bInBQdAmWwPBSDD8D1GCU2Rm/EKL7sQjsN5LnbjQTBstc3BSPiic7qOcrsWiMdHghjtn5L+Lo=
X-Received: by 2002:a05:600c:6990:b0:48a:7aad:4425 with SMTP id 5b1f17b1804b1-49036034012mr30158435e9.3.1779354552529;
        Thu, 21 May 2026 02:09:12 -0700 (PDT)
Received: from f (cst-prg-92-135.cust.vodafone.cz. [46.135.92.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa756d61sm1354219f8f.0.2026.05.21.02.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 02:09:11 -0700 (PDT)
Date: Thu, 21 May 2026 11:09:02 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Bert Karwatzki <spasswolf@web.de>, 
	Christian Brauner <brauner@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
Message-ID: <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
References: <20260520225245.2962-1-spasswolf@web.de>
 <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>

On Thu, May 21, 2026 at 10:53:03AM +0200, Mateusz Guzik wrote:
> Christian, can you fold this in please.
> 
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 771fc31a69b8..8f17c0abbc95 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(void)
>          * Did someone beat us to it?
>          */
>         if (old && old->gen == file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 return 0;
>         }
> @@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(void)
>          * Did the list change in the meantime?
>          */
>         if (gen != file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
>                 kfree(new);
>                 goto retry;
>         }
> 
> 

Even better, I got the above fixup + some polish listed below: 
- removed an extra space in newlen calculation
- the WARN_ON_ONCE case needs to free 'new', not 'old'
- there is no READ_ONCE anymore in filesystems_proc_show()

goes into the "fs: cache the string generated by reading /proc/filesystems"
commit.

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 771fc31a69b8..712316a1e3e0 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -269,7 +269,7 @@ static __cold noinline int regen_filesystems_string(void)
 	hlist_for_each_entry_rcu(p, &file_systems, list) {
 		if (!(p->fs_flags & FS_REQUIRES_DEV))
 			newlen += strlen("nodev");
-		newlen += strlen("\t") + strlen(p->name) +  strlen("\n");
+		newlen += strlen("\t") + strlen(p->name) + strlen("\n");
 	}
 	spin_unlock(&file_systems_lock);
 
@@ -289,6 +289,7 @@ static __cold noinline int regen_filesystems_string(void)
 	 * Did someone beat us to it?
 	 */
 	if (old && old->gen == file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		return 0;
 	}
@@ -297,6 +298,7 @@ static __cold noinline int regen_filesystems_string(void)
 	 * Did the list change in the meantime?
 	 */
 	if (gen != file_systems_gen) {
+		spin_unlock(&file_systems_lock);
 		kfree(new);
 		goto retry;
 	}
@@ -321,13 +323,12 @@ static __cold noinline int regen_filesystems_string(void)
 		 * generation above and messes it up.
 		 */
 		spin_unlock(&file_systems_lock);
-		if (old)
-			kfree_rcu(old, rcu);
+		kfree(new);
 		return -EINVAL;
 	}
 
 	/*
-	 * Paired with consume fence in READ_ONCE() in filesystems_proc_show()
+	 * Paired with consume fence in rcu_dereference() in filesystems_proc_show()
 	 */
 	smp_store_release(&file_systems_string, new);
 	spin_unlock(&file_systems_lock);


