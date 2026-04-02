Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43DC2FD66D
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 06:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111837; cv=none; b=JE+tQk2YNQFCSSUwS6O6s8J625sHJTtxrf4QY/WK0xumX0AX3biJjNMZRq3lFp8/Cn+w1O9M2ubaKt1RUfZMmupLVoZVnGu5q+LaVKUKJ12o9o39HWlMj0PqZPtnYlFS30eG+cUtEPKmxKnA+kpXQ7tblsU5+bdCNLbDUY7dWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111837; c=relaxed/simple;
	bh=2ID5HnImRXBwq7m2lS4nX4rs2HBuzrgCxIPBw39/5jA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLrh2oUNuFps4GrOW8NHvqEvK8aHzeeEyp9HHA/TSGq0jdyV8jQctGuM4/aj2QFFDNmGnqz7mcxB3yF7Za8eC+katDMNT3y1QsGWe0a682JZY2a/hzuk1DEkliGqI6nVneXMVmtSKZGs1SWAQLmQVCaOG2+JjcyY7gHEkTDgDf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xpMSbTr5; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xpMSbTr5"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b258576d8cso3276065ad.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 01 Apr 2026 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775111835; x=1775716635; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8/3v+kCVvzkJZkARRBkgOLxtlDKiOvmDPq30N7asvM=;
        b=xpMSbTr5PB/d9TwKxuxp11lnvkZsFHvV1s+kL03PZ5BTiX2MBkrVFbey8jCiZfOHkr
         OFxvebHyv4qKNEHdSHfWaVc0Bsg4ozkmyj7CSCZKhj2kNwc+FcxVY7W+ljON5OYvmnMx
         7I2zf1/H7T6i82j9SxvY9zuWHPS3ji6A7o2scAup5ClPiVMa5t3JXfAKCtRyo0upzp5u
         arKjgjLybhymqtm4SvuVqwhTW6S2kocSsx5MUBaeKAy4DexL4GR8WUd+fJi3sBDs20bD
         M0UjdDyQTbeV4dvM/Pi1vJBF9cpWf+IHKqYU3R/Is0LaGzQujGfSqhOBxi0D04L0AYcD
         dmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111835; x=1775716635;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8/3v+kCVvzkJZkARRBkgOLxtlDKiOvmDPq30N7asvM=;
        b=NiLeAKjXFmLfhUSCKfZFnLzKk43ya1a2xPyeXGsGKP+RBMHSjVcbwUjX4dn8VwXgbP
         vrtDp3IKOh+Rk3r/KGcYy+LsawSgKKwnXZhP1KlJERhlPEOTeoEqUHRZk/WhVENp/qA3
         6am6T5HIeMVZM1WprX7JLI97RUgkwRppNveyDfIImKPwqV+cSQXrkUixcYj5fP5kMtse
         MLbLnZIiSlaKXzGAyVqo2FEpYPtPBoHzPk320dJxQ96FdiRc3/4lzbDqZ5z2MDb0Aj5S
         4+/D039FgJyWl0khBccTXF+eiH956Nz88HwlzuUeMz5wODoabzJfuiec4wcl3G9JqK2m
         UgsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkJhUwyZl06OYqDq7fvNl+V3TItJntmWjnlePi+wgkMvef4BOuGCqkSPi4s/RtIOs5GqTgUMkmN25Xx+dNSQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw5qvzv22V5SpPi8qnLFoNx1Le2BRExGxnatw+5AfzKx8T2dL3D
	lEMIO9fQRhcCI7WY+xESOjp5zOdTdHASNb8+H9M6+hcN4szdwRQKWtsCBvXCn6TdWyA=
X-Gm-Gg: AeBDieuz87t4zy5vF//jnjt7UQVHMg373y8IsWl+JVWkjbrn+rPe7SxOCBNrGnt6fQT
	y+DvmLflTHOskRItJ2O8mWzH51q4M7P1AToEkOOaRW4OeLRddCA7RBlcYJX4lvL65kCn8lTGqcR
	dqsx61EwY+g7sEB8FYw5R5W579LUmLE7+VBTiLbX9n82brR6nbGJaYoGfa/YgPPGmdSecT3mWCN
	VxXpVgVTZdtNMd0GrJVtIz7sQ57Au9f4VJa6px02xbHvHj38KLJ/S5LMfhFPdRTH8nTATfOgqvS
	IORbVL7ZwqBYzbc7O0AohE2HINRRGuu1kO7kGuge21S/rjTL19MqBoBoMtsZg/5Q3EDAtsxbvSE
	zyrPuqp98zctxh5x2nwZBAxHwUMhfBX/P50rygyIBGdClnkD3pGViVobafX4u9QVn0nlTGnWiJt
	rj5VwieyDHC4yiJ8H7WAVQSzae
X-Received: by 2002:a17:903:198d:b0:2b2:58b6:3dae with SMTP id d9443c01a7336-2b269d14011mr58436245ad.46.1775111835057;
        Wed, 01 Apr 2026 23:37:15 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27477c54bsm22677075ad.27.2026.04.01.23.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:37:14 -0700 (PDT)
Date: Thu, 2 Apr 2026 12:07:11 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Perry Yuan <perry.yuan@amd.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Mario Limonciello <superm1@kernel.org>
Subject: Re: [PATCH v4 1/2] cpufreq/amd-pstate: Pass the policy to
 amd_pstate_update()
Message-ID: <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-2-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316081849.19368-2-kprateek.nayak@amd.com>

On 16-03-26, 08:18, K Prateek Nayak wrote:
> All callers of amd_pstate_update() already have a reference to the
> cpufreq_policy object.
> 
> Pass the entire policy object and grab the cpudata using
> "policy->driver_data" instead of passing the cpudata and unnecessarily
> grabbing another read-side reference to the cpufreq policy object when
> it is already available in the caller.
> 
> No functional changes intended.
> 
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
> changelog v3..v4:
> 
> o No changes.
> ---
>  drivers/cpufreq/amd-pstate.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
