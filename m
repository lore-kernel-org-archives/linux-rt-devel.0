Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1471F331A53
	for <linux-rt-devel@lists.linux.dev>; Thu,  2 Apr 2026 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775111999; cv=none; b=F5HmnjavK1oadRUpkl24RrX2XrEuUlEx/3hlg8zNI/+njgLuw3vUx9yHuWpSdvWaLGGbWdOtSCRpdHs8Q+LKlfjI0U2ZJcBFaxGmJUJMV2JgMeDOK8YAkoOxZgduiHmoa6L9aIcYZsHPv6zo+8URbXIddypmilKzLCz7r6Zs/wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775111999; c=relaxed/simple;
	bh=F92uNx124eo6CuTR2SkIUKUgI7gi65kPAs8402itiy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1icd4dl/YXvWfO430Jy8OXMdpZgVKCCBCG4DGPr8twT1/JR5sSLSl6g7SvlkCsnwXV6HdlRlPcmVYCHlJd6gzOzK1bp/cZ/sNBm4eGKn4dChL/iFPLs/H2yewgw7ZT8pdwuXZt4ASrKjWoIslijamZIO4NZOoxiye9o4r7URZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z0oQ7ch/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z0oQ7ch/"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35d8e548a05so478514a91.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 01 Apr 2026 23:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775111997; x=1775716797; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O6T2dQvI1mSEP2cZOOFDJ0349CayIDKQeIFznfl4/Jk=;
        b=z0oQ7ch/U8zuSLnCEOPtxbePom99Rk7uz+Nu2GUrVUriPsoLEKG3KZ+8MnmtO+obsx
         8NVivyaK/1cfh3d8ZsDmIoag6e+ewovUd8CtN8MVc6W4dCXSLjvAa/0aifaPa0kq5TiZ
         p66bWJe1ScC/tYoSgIDIAJZac1KBoaE6pCWa+7D5cAPKgDsM2ANldQN1gBWTtx/1uR6X
         on+Bpabp5uwXshXK4Ie3voOmL6ReLjXXR1hOJ3G1XXR0UhgN0bRGFxO0t9lmw9dNSvYe
         1wqYPz386N/Dp0VbV4avLhqWz/JwxSVtVlIGbrP2omwa20H/lLIZV5FTjW0LAylYDAAw
         zU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775111997; x=1775716797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O6T2dQvI1mSEP2cZOOFDJ0349CayIDKQeIFznfl4/Jk=;
        b=IrB6iGxYxBhy+lJY3VxsFQjUthp1whSdccHPULEowG5e5Sqd5ZC9B7b53m9ZDhIhz9
         drZsu6LCMLl6BJyCi6fpk7xWCHGJy6APj2gA6+pk1SxHg1JcO7JemoKmmj2y/FDcJzmh
         PalwwRlu2WeeargLH7Qs8mFlZ7603FMiX+M8WzklbDjzlNDUiLhc1WFq7rDCvFFE1Kga
         juw08+TGSwUHdSIMGlvNHTK9QouXVbP6spT1EDWkzcEtYRLnVyyvwCDtq81Sjd14gyLL
         lIy1BQHcY4I7Z+Df+T1qA9b+K+gBVP08CaYHLyOR5Bh6etlo5hgafPisc/cYi2AXl1bH
         6F6w==
X-Forwarded-Encrypted: i=1; AJvYcCUlNrmcS2Eo3Czbn2IZK0JGOJs6pE/e11QmclwhUjzBpSGupa7atDB1AikUCMCG9trRqM9IJxO2qB4oOvz5gw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmxDCliYyteImRmtNgMXNe14Levv3SHEwrY6wK9pcNm4swtew7
	wSdxLHjD+BcX3lM5/dGRUDNhgz9aVNS75XKklMT8ut7JdWw0Z5TCHNFCOiNoloXbtug=
X-Gm-Gg: AeBDietiEOh/c431oNIPdiTQwbkpa9FiJfIFAfsfwruf70f6D+t1+XmqyecvQUeWr0m
	8Th2dV9qu3mWqcE3OB8nwJXb5GyBE4/USBiJSWMfyq1rUVwFT0eGK56Aeo2lKloHCz9weDgXVgJ
	IhfOmROyAZ/VZTy5lhl85nMjK+mprZ2G52SX1sgqo4Ijftkxtt3uy/1SJ337NXNVCrQsfk7/Feo
	Q23EVxt3sF7snxHAoDES9N2rqvaa+jp2m0Up7a/exYsAn4sKWqt3S/LTTDAHZVmUAmkBLjRPlKB
	1tUQGqBpp6ht3dvQp9er7wWbTWGuxyvkcOdwFgBNi4tpgDajWyRu7AG2hD1uJAEYMyaRPfh7yzD
	H+ropmbJ71mZ22s8KROH4ZdKThHgfxLUG0nBM6g1BfM2Eonv+efaQIBZc7MI5eYf1bc00HEgD58
	fORPUm5HNHR1lcaYxLCZkhDVlk
X-Received: by 2002:a17:90b:4c8e:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-35dc6f6a323mr5986457a91.19.1775111997319;
        Wed, 01 Apr 2026 23:39:57 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dba54797dsm3316950a91.1.2026.04.01.23.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 23:39:56 -0700 (PDT)
Date: Thu, 2 Apr 2026 12:09:54 +0530
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
Message-ID: <4bwfgnjiywkm4dyslhzmk6lvar3a6rhvtcyyruc7okybckuwuf@mkdc5dlconx4>
References: <20260316081849.19368-1-kprateek.nayak@amd.com>
 <20260316081849.19368-2-kprateek.nayak@amd.com>
 <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hin33mzxwjjycw7oonq4klqmgmgavqpoe7r2ml6qalytxfpntk@me7d6q6yiec7>

On 02-04-26, 12:07, Viresh Kumar wrote:
> On 16-03-26, 08:18, K Prateek Nayak wrote:
> > All callers of amd_pstate_update() already have a reference to the
> > cpufreq_policy object.
> > 
> > Pass the entire policy object and grab the cpudata using
> > "policy->driver_data" instead of passing the cpudata and unnecessarily
> > grabbing another read-side reference to the cpufreq policy object when
> > it is already available in the caller.
> > 
> > No functional changes intended.
> > 
> > Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> > ---
> > changelog v3..v4:
> > 
> > o No changes.
> > ---
> >  drivers/cpufreq/amd-pstate.c | 11 ++++-------
> >  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Oops, I already Acked it once :)

It is ready for Rafael to pick now.

-- 
viresh
