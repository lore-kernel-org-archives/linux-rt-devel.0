Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BACD1448E4
	for <linux-rt-devel@lists.linux.dev>; Mon, 16 Dec 2024 15:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734364378; cv=none; b=YUE8/uDuWV+fdFHSWVCiZYbT25KY51d+NQ4fOxqQDNstGaztMIOvmvcctN0MFKGwI+WyBnOMgBIUUHIjuX9WfM0nSCqi/aMYTOlgJV8FWESHwkvkSLz1TEaTaVRAzXGtuFa052EEvkF/j2IeDzZEEgkNFu2Jv9/3kMn4ZwQBoJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734364378; c=relaxed/simple;
	bh=oGAvYTUda6zsqAhxih/iNc51wzbk5dR2ZYfn9oKE79U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IveJzAmuM4QuJ8lN08Rwacx7N22yo9d7JnFiVDfqQkeFXADELbJuYOWa8wnCmJ9Pv/+Al9EJTiWcbUymnbx3Ct/JpcrTMV2Yg7UmsuhqjYr8UpogFJgXiaVpSuUrRQvLwzy5cNvlkbu6r2tdN6iJtlXeVDqJxfuKzkd/Ybrjoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KUyZrUFD; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KUyZrUFD"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862c78536bso189529f8f.2
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Dec 2024 07:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734364375; x=1734969175; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=38FKdhz1VvDhc/ssvKRblfgMS+wpHTOD89YDjFr970E=;
        b=KUyZrUFDxYw/xnKQIZVvesazv1xEJGjnVe4+bTISF9hIV6L1Afltxz7hn0b68VhC+J
         Mpyt0aYc4aXgBeG90o6xUtDD6cecwVu+57EpcdrmkewLk8j9hi04pr1O4CN8sjj7V18T
         k9QkaeXEMOfxFp0gtW7pxEVdOJz49BrF2eGCgexKbCGQCTUsLL9DgA77FycnMR7ISUZm
         /4rdfC9D5s2oxAflJWkEkZUU+hUmZdlpfsqKINGQ0i21w+ewCOUVoBuC6LzdbxhdubtS
         lDNbUMn1pwQ1XBD+GN4LIi4KWEobCy8gQyjCcu3X1rl3/JVlPaPC11f8oj/QC9A/YVsg
         6kLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734364375; x=1734969175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=38FKdhz1VvDhc/ssvKRblfgMS+wpHTOD89YDjFr970E=;
        b=DXkfcfmno9rBA08E4GaujkxXQPwmx/vXQ7y/ndoZlHqxmnl2YcL3ZSM7tLoomAYdTc
         J8LtahRtHZXtiAVsVcvqG0gydWfbaDa3IdCgMycaIjYa2j4oUYo+xGzAPQ3cND+zQGnQ
         tXomLUr2YW5xwXGrN6RdxxS30u3KXC/wuqiYqAYRmlVjhPsNV5qovs+J+hdSFBPaGofJ
         rjgpyGRwDrxfEMkdKRNVJpIIlizykulENK6i+2uBNros/cq4bBX+0Nl9kgYEIG2m4H2L
         ZXCEEv1GAzodZlNWyH9WgJhN1PeG7OdHGpZO/jlTJUOevB6/Rp7AH/jDLseQ7sx/RbW0
         orpQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6iCR4erdlGeswJ8kRdadL+Fa3OMMvtqepdhqr4/YOtsqfD7YuOTwUP2SDucboGkEFZtpqnW8975C8nEfLnw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwgqbRBDLT4CHzQ7ezIwCdK6wp6mIOl6gOahITCIPcRXWHk0qwX
	6dCq/ly97Z6vbItwGijP/yUz0qmDGFZd8D2XsXQO1Rnncz9X2gMck8mos5o6HfU=
X-Gm-Gg: ASbGnctORFQuUsCO6G3sTuzE1u4HxrqpBjBvCchhDxcxKLWMa00lA6RrbHIXQROWrox
	Qhq46aqDgJpgOQZx4abqDaYSvmJGxWl4frJHRQ1yVFfm2rBzujMlioDO3ZQg+1NSPHvv3YxwnoT
	OAs93WNfOHLF5iEoBACo7RQbztFw12KVEb6jYOQ3Fq45/zlrn3+X/fPePzituzfCmeNhSfBiBvJ
	TwyPOSw5g8a/kqstvJYpGP5uR2N0dP5utWv1D7z11kJgimvfsXyDdz2OdFxq6ot2mD7b8qcAMa3
	qmTVbiRqWWCcVKMKmM94vYkzdTsTr/8+SzcyTRgN+y1G4wEOlthLhPautBfgwQ==
X-Google-Smtp-Source: AGHT+IERJiZgYVHCfr1v98k+3qwUb/e+s8BAL/XMJ5t/zmC887eRAbHa3krDvJnb+Btr6fWCPTHiqw==
X-Received: by 2002:a05:6000:4b04:b0:385:f0c9:4b73 with SMTP id ffacd0b85a97d-3886c72110bmr4641130f8f.0.1734364374759;
        Mon, 16 Dec 2024 07:52:54 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c804d573sm8397658f8f.64.2024.12.16.07.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 07:52:54 -0800 (PST)
Date: Mon, 16 Dec 2024 16:52:48 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-rt-devel@lists.linux.dev,
 LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.13-rc1-rt1
Message-ID: <20241216165248.5cae6311@mordecai.tesarici.cz>
In-Reply-To: <20241206154701.8XBv1qNE@linutronix.de>
References: <20241206154701.8XBv1qNE@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Sebastian,

On Fri, 6 Dec 2024 16:47:01 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> Dear RT folks!
> 
> I'm pleased to announce the v6.13-rc1-rt1 patch set. 
> 
> Changes since v6.12-rc4-rt6
> 
>   - Update to 6.13-rc1
> 
>   - Down to 24 patches (including three new). The v6.12-rc4-rt6 release
>     had 42.

Great job!

However, I found 26 patches in v6.13-rc1-rt1-patches:

petr@mordecai:~/src/linux>  git ls-tree v6.13-rc1-rt1-patches:patches | grep '\.patch$' | wc -l
26

It turns out, that these two patch files are orphaned (not listed in
series):
- netfilter-nft_counter-Use-u64_stats_t-for-statistic.patch
- riscv-add-PREEMPT_AUTO-support.patch

What is the reason to keep them around? Is it even intentional?

Petr T
