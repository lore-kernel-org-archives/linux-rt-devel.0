Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05F829B217
	for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758015728; cv=none; b=rPyF/VagUlKtIIfmZc6wRU99ICgqNrpftCcmqLhlbSfTchw6llXfvPTJU1iPThuVmt9ECVwymQCgjg9q4GCvrnDrWzy0yjFCdwluqxqlEnffneeh5HyIbBlACzSqLCFLIWDRAtMppCAHG9jQJVWcb2NNQO+0I+u7/feAO2cbnWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758015728; c=relaxed/simple;
	bh=wtSv0L6/GwqZZywYhmXmG694rGZXr5C/8JsbMi/MtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Amh+JZSk01eviVpiwum+rIGYQvJjT96NTW/brKRu1HUgwARKUQzlegcaNhg4J2XPTaHGOr+UiuEDytwGcbnoVcVuqH5Ig+/U54ytI6r8CRq7ouHfCoY+XDwhDQUEhEak/DutNBP+7pLw7CeFsmmhcoQlJQuoW1ChKg707b980nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V14WAlth; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V14WAlth"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-351f5cec42dso31933301fa.2
        for <linux-rt-devel@lists.linux.dev>; Tue, 16 Sep 2025 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758015724; x=1758620524; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=V14WAlthitumWx00i3cQ390GInryWufkBA8gcatNnn+N9Kgq/wjhnwNE4D8SDWJklF
         iYTZGQzCP+1JM5bjpDv2QTWBFIB69r4LMDp9kLyI6tBw+jVDGF5LeuFGtLWaLyQmnjq9
         tRRNQzgUB+o8+TPYPs0nNqwWAZntpf9p4gIJHs0QPTRNgPXOddGm92sAGVI+sI+J3aMP
         G9CI2Ulvi1vn/l90Xd/9JCZmGbIh7lMhDOqKy9YUNhXJKrXj8QE20F3LhkDvfbkbGAsp
         2TDx6DLzq6gj35GQ53OU9uUxUZLGqYfSX0YdJ6WVhQN1uJ/yb/3S3bpdgp6DU124bh4x
         fsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758015724; x=1758620524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haBjQsvE5vE3ZaF/RXUldLy+CB1Z0cpROeB+NEV/yO0=;
        b=av5tSBXw7mQYkMmMH143wohU+AZ7hdpJHpbz44bb5MqZYIMVPFVPnj4WSLUl4ZTi7s
         5VcOD0VdBm09duTGV1XoaBAIOVOc1K7tgenmFY4hbw1d2UYPSsmn+vGwpxWCOSXL4BjW
         cPwsHWrYcM8f35KIN+n5T5q5cnVHiErpj/VVPIw8A2jbhpvnZf1nNI8zbVP4vhFudTl/
         igHwIbRwxEugQl1mOFnOArNXYY6kTCqGRD3kheqWQv/RyW9qAqXWwwTkUbi7FE9mzrDU
         4EG7C2XJTM+mXLUVsEa5MIOLI+9/ZvL5EuGmitI9XVOHE57yX1HP2ks6UBCNLMQPlid1
         5dXA==
X-Forwarded-Encrypted: i=1; AJvYcCU874TaQMx5EKyn4/RIdwZd0slKi3mTDsP1icxkz3T18Pp89+xBs97xjv98qmQWHiUQIGtg+VNzUMcMHuWg8A==@lists.linux.dev
X-Gm-Message-State: AOJu0YwYlDHKCkm1GW8TE0FnaFmXeDy7ZvJ0cQ5k8Tdk8dlI9dgjv9N9
	CkO5YbmQ8zePJa4uTVXEUovlTPZlYt3q7myH/XTadiMZCBBkGXPwzh0S
X-Gm-Gg: ASbGncvM+3iOSR2ddt3edsm26XwMgziPJKj+/PsnXmKeEssOzcPsZAZ1+ofih7IaBt8
	c5S9VJ6TV4rT2yAV0kuHohrfZQrd/putEy5XG71GulX1aGV+6Er9Sf4NSVU23K9vEWPT95OzZHc
	xfChBg3j2KV7Xxj2eUXyvZ10tqDp/IIpOtjAsn3/4/r3lC25rKiG5JZcXSWrKfjOPssAmHPDk+m
	z79iokS57Vs660++KmnPsHbJ7YSAltALRaBwtpIStDm9IhE5GYua8Aer859MlNCdMmnHfkp3Hbf
	xLuhvzTQBbgPS/VD7/x+4XvDDfBzqggNFh8zz502Zerbl7uKI2zJD6ckcRHI7yw4gJaaNB71jyO
	he+tTdqFEjGOklPacj0gI5j+pRt930MCW9Ji68XBuG9Casw8=
X-Google-Smtp-Source: AGHT+IGHsAz1XUgqjX9cBNXDDceT4RSYaRrx53ol9Kht+YGnRRfTcQN5imeqv3DeXohNMYqhdx9Bfg==
X-Received: by 2002:a2e:a00e:0:20b0:34a:7575:36db with SMTP id 38308e7fff4ca-351401fd0f5mr48965051fa.33.1758015723646;
        Tue, 16 Sep 2025 02:42:03 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-34f15a5835asm32481881fa.4.2025.09.16.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 02:42:02 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 58G9fwKw021585;
	Tue, 16 Sep 2025 12:41:59 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 58G9fts1021584;
	Tue, 16 Sep 2025 12:41:55 +0300
Date: Tue, 16 Sep 2025 12:41:55 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: pengdonglin <dolinux.peng@gmail.com>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com,
        ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com,
        bcrl@kvack.org, trondmy@kernel.org, longman@redhat.com,
        kees@kernel.org, bigeasy@linutronix.de, hdanton@sina.com,
        paulmck@kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-devel@lists.linux.dev, linux-nfs@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-s390@vger.kernel.org,
        cgroups@vger.kernel.org, Samuel Mendoza-Jonas <sam@mendozajonas.com>,
        pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v3 11/14] net: ncsi: Remove redundant
 rcu_read_lock/unlock() in spin_lock
Message-ID: <aMkw4zTLRJqpVGCm@home.paul.comp>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
 <20250916044735.2316171-12-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916044735.2316171-12-dolinux.peng@gmail.com>

Hello pengdonglin,

Thank you for the patch, looks reasonable and justified.

On Tue, Sep 16, 2025 at 12:47:32PM +0800, pengdonglin wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
> there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
> rcu_read_lock_sched() in terms of RCU read section and the relevant grace
> period. That means that spin_lock(), which implies rcu_read_lock_sched(),
> also implies rcu_read_lock().
> 
> There is no need no explicitly start a RCU read section if one has already
> been started implicitly by spin_lock().
> 
> Simplify the code and remove the inner rcu_read_lock() invocation.

Reviewed-by: Paul Fertser <fercerpav@gmail.com>
