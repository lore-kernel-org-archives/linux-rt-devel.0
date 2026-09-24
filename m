Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585C341A504
	for <linux-rt-devel@lists.linux.dev>; Thu, 24 Sep 2026 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270948; cv=none; b=PF0msdarakXulDiOxhC76aGFpHp3V3xNTAfkhQn+aEWC7XO595AADILuE5HgqkjBZpfQ4AhAQQdrHo8z9/iFsjaB64rpR29bj0GBK5i9JjmnVrLVtKoUb0L95U7xJq9bxgmmzI3PMmPU/DRhs3gH6xnfpJwGZuA0O3P0mkrFmXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270948; c=relaxed/simple;
	bh=mRX+6RgjudFX3w/AvoHXAb2SkbXZDaFnBAiX06s9qoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUzwO12P90yKLzxWNu21Nmp1EtB3L+EJ/cYwDSo9nx1/LKxxE4TGwSibiQTEAbrqLjUp5ZrSEEn1SHcVJxvIvWK7IhQXik1yhsdWd2U5voyFvdlPQC9fBaFzkPR3dvNp5YgNEIKMYmuBefEnmL4GMXabDNwKKlbdLriJh5uES+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Yf+pusJz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Yf+pusJz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 269BB1E4D;
	Thu, 24 Sep 2026 10:29:01 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D01FA3F86F;
	Thu, 24 Sep 2026 10:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790270944; bh=mRX+6RgjudFX3w/AvoHXAb2SkbXZDaFnBAiX06s9qoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yf+pusJzIbF7VE7VAJ4KcI6fhVLDD638gbaF+c3YcVoa8EnIPdamHr+U7REFb2BEx
	 zxMydX3eCxlPiD9sBosG7SRp956xbjPcLY7yOXuRLzqYrB6mpkiHFhwE0FkzP1lP1s
	 l4zyk1fkCmYQq8N9Yd+oglKpjprTKikQCZYqR7gs=
Date: Thu, 24 Sep 2026 18:28:59 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v11 0/9] fix several inconsistencies with sysfs
 configuration in etmX
Message-ID: <arVd2zXOAY1pa5gZ@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260924152543.GL200420@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924152543.GL200420@e132581.arm.com>

On Thu, Sep 24, 2026 at 04:25:43PM +0100, Leo Yan wrote:
> On Tue, Sep 15, 2026 at 12:34:35PM +0100, Yeoreum Yun wrote:
> 
> > To resolve these inconsistencies, the configuration should be separated into:
> > 
> >   - active_config, which is applied configuration for the current session
> >   - config, which stores the settings configured via sysfs.
> > 
> > and apply configuration from configfs after taking a mode.
> 
> I did the following tests on this series:
> 
>  1) Perf test on Orion6 board:
> 
>   # ./perf test coresight
>   142: CoreSight synthesized callchain                                                                           : Ok
>   143: CoreSight concurrent threads                                                                              : Ok
>   144: CoreSight context switch thread attribution                                                               : Ok
>   145: CoreSight deterministic workload decode                                                                   : Ok
>   146: CoreSight raw dump stress                                                                                 : Ok
>   147: Check Arm CoreSight trace data recording and synthesized samples                                          : FAILED!
>   148: Check Arm CoreSight disassembly script completes without errors                                           : Ok
> 
> Test 147 has a known issue with per-thread mode. The failure was already
> observed before this series.
> 
>  2) Strobe mode test:
> 
>   # echo 5000 > /sys/kernel/config/cs-syscfg/features/strobing/params/window/value
> 
>   # echo 0 > /sys/kernel/config/cs-syscfg/features/strobing/params/period/value
>   # perf record -e cs_etm/autofdo,timestamp=0/u -m,128M  -- perf test -w brstack 3000000
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 36.301 MB perf.data ]
> 
>   # echo 1 > /sys/kernel/config/cs-syscfg/features/strobing/params/period/value
>   # perf record -e cs_etm/autofdo,timestamp=0/u -m,128M  -- perf test -w brstack 3000000
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 18.361 MB perf.data ]
> 
>   # echo 2 > /sys/kernel/config/cs-syscfg/features/strobing/params/period/value
>   # perf record -e cs_etm/autofdo,timestamp=0/u -m,128M  -- perf test -w brstack 3000000
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 12.246 MB perf.data ]
> 
>   # echo 3 > /sys/kernel/config/cs-syscfg/features/strobing/params/period/value
>   # perf record -e cs_etm/autofdo,timestamp=0/u -m,128M  -- perf test -w brstack 3000000
>   [ perf record: Woken up 1 times to write data ]
>   [ perf record: Captured and wrote 9.197 MB perf.data ]
> 
> The captured trace sizes maintain the expected proportional relationship
> with the period values.
> 
>  3) I verified the series on Juno-r2 baord with insmod and rmmod, and
>     CPU PM, and did not see any regression.
> 
> Maybe it'd be good to send a new version addressing Mike's comments.
> Based on the test results, you can add my test tags:
> 
> Tested-by: Leo Yan <leo.yan@arm.com>

Thanks! ;)

-- 
Sincerely,
Yeoreum Yun
