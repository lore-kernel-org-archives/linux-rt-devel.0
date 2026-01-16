Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA319346A13
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Jan 2026 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768538712; cv=none; b=VT2wYYgzCc4oCEOjUmafioqDowdGfdCjljsxsLIDMMpLB0gLye/sEAXCsAhLIX8ztdXACV/7R59v/SXktcoSr4UVgfup5s+M8V/VeykCh3VwjdPU9UjLnM0ieGexUv+RtOwmuQgrckZdKd2m2FzR2RtpnP3qGpIcT8x/2O3HFUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768538712; c=relaxed/simple;
	bh=qvLwpSrQnWFaQHhcymHGiKAckW7z2fLD6nZgVN0pk/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOjEYZ+Rb/wLxQxtccYdNVQFniumZU/4FsUAlbU+71cq0D4YnQW7Jo1w5gq6dH69F65z3AHPQfMFfAVKR1shA0pyjstZ9j+W3VDwSUFRxDSVO8ntODWi/h/MfS0SK47p2UafWDv26gF1rv6B5MNnQVJWVEFpIu7bbH9RaHcjghY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEdhHijV; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEdhHijV"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a0bb2f093aso9622615ad.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 15 Jan 2026 20:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768538699; x=1769143499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l0USPLt2B+noNFBNiV821NXHHZvHrFhQTCs+tPkiE6I=;
        b=FEdhHijV+eOs+D1Vntv4a2DxI/z3pyPv1m3MHHmngvjlBnDU8BxNNw6h0q6POTpObX
         U57Jy/YFN7udCLTfEZzYJ+yFET9acqoIYpZbWgVVzDMb//RxGX4jU1s3nAWYE8fMSMXk
         8pWp/+7xdFwzOCsZqNFtIV1Q4LD91U8F6Ecnc3f+Z8jqLNyRfJjI08TavEA8iWk6VD1D
         /SY7jkQtFjxpDiYlnBlSW9a1DbHT88UZSfON4ATO7kLL95UQNNUyM2gTu6SlzZz3IFV2
         ErIlkDTcsqHi7oGosu1FvLQGrXCaDJhEq+s8ijMrdyL50scfJsKpcpl3+ruavHt4EYE7
         Outg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768538699; x=1769143499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0USPLt2B+noNFBNiV821NXHHZvHrFhQTCs+tPkiE6I=;
        b=pWTQao+KbnMLuSiEo6KkRdqTTPFxFart6NuU14brbbC8StKhDX74wjxKoGGEgcg7dm
         NJSKhdYLLs8g+BGa/kkz2wbdzb64sSRgjFBC9tsvatXndNS0En/N/U1S5HdH3WxQvL0l
         D51L690WnGAL/iU58/Knu3WNABcXqQ3xwdDvfmYHbP8BnQA6yk9TF4hS4SFns5AB2X7w
         l3eRc6YGuiYWiKQkoBrlxNrWbNzFuxI31SgSgibs5ONYcv5j2R/h8E2DxsX24WTr89sI
         iMbXxedRY4U/2ec6/Slar+vj9eSoG/JNxoiJB5N8/UPOGhIaGvWGflvKWKT3JNWvUHRc
         NmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGwcY66QH+SU6ZnQqJkBU489ddiaNJ2xKA9sPEYNErGbsJylvg7xGqAc2+Ivk3W/jkAe/BwMNTINqfIsSiAA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwDB2KsXkk3SzvRZ1C0BwIFZKbad1DzGuS+FJfPf7MWDAO7pae4
	83Y53hiOqTETw6A1aDeh7EIGuHeoD617ywuw0VLc+TDGCRxkmf3WmfPwV/P9OclQPZA=
X-Gm-Gg: AY/fxX5OW2nLK/vIELe8UHnZLks++UUNvUJWxaKILkCUzMJiYc+6TP8maZD+D9JELBI
	MS4vTHnyi8rTxQFJr3/zD6iGKRGWBH4Gb6DEEhAQ/6cNIz3P9C3jNt/LTJz57Lwkg02qTLb2sjC
	d8KwBbgjVxnT6RyYxX66F799FLnUdbJyS32uD+SkKHO8p2SaHfQwuPCB/d7d0XpMJxGXtEmIvC/
	YoZsx+nrRimZLgbF94sY7zTi3s/acu7Nj+wVhkVqIvos4TXYoG2OoahqjeFZJwhDVyHLtSWAhkX
	GZ4ALHbYWCBimBvOBXg8G3Y/HX8zWq9eT2Z53KG48MxvOl71AVtgI38ZJU71SOd2XQ4qJWRU8r4
	ufN6xavXQtntPZAQsGHiW/O72qnRxxQjOZ4wcWg/XVeYLWY4XqzRTnwIzPx321bzPMciqn2XuNe
	C3QDoofuok4IE=
X-Received: by 2002:a17:903:13d0:b0:2a0:a92c:2cb6 with SMTP id d9443c01a7336-2a7175a63b4mr20341575ad.36.1768538698802;
        Thu, 15 Jan 2026 20:44:58 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193fb372sm7887045ad.72.2026.01.15.20.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 20:44:58 -0800 (PST)
Date: Fri, 16 Jan 2026 10:14:55 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [PATCH v2 2/2] cpufreq: Pass the policy to
 cpufreq_driver->adjust_perf()
Message-ID: <rs4z34vntq4inwbl6nhzwsmefcgud33a4jpec44ff5ylrxtnur@rczzlmhgejky>
References: <20260114085113.21378-1-kprateek.nayak@amd.com>
 <20260114085113.21378-3-kprateek.nayak@amd.com>
 <bqvpt465nowq3jipfsciaoafjpjhu42l63vi6p67qscwx5oil4@t2tkh2u5giuy>
 <6eabf604-9168-47fb-8fd8-b2f0d985db6a@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eabf604-9168-47fb-8fd8-b2f0d985db6a@amd.com>

On 16-01-26, 10:08, K Prateek Nayak wrote:
> Guilty of not having CONFIG_RUST enabled! I've arrived at the
> following after tasking a look at cpufreq.rs (specifically the
> fast_switch_callback implementation):
> 
>   (Only build tested currently)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index f968fbd22890..bea109f8ff78 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1255,18 +1255,17 @@ impl<T: Driver> Registration<T> {
>      /// # Safety
>      ///
>      /// - This function may only be called from the cpufreq C infrastructure.
> +    /// - The pointer arguments must be valid pointers.
>      unsafe extern "C" fn adjust_perf_callback(
> -        cpu: c_uint,
> +        ptr: *mut bindings::cpufreq_policy,
>          min_perf: c_ulong,
>          target_perf: c_ulong,
>          capacity: c_ulong,
>      ) {
> -        // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
> -        let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
> -
> -        if let Ok(mut policy) = PolicyCpu::from_cpu(cpu_id) {
> -            T::adjust_perf(&mut policy, min_perf, target_perf, capacity);
> -        }
> +        // SAFETY: The `ptr` is guaranteed to be valid by the contract with the C code for the
> +        // lifetime of `policy`.
> +        let policy = unsafe { Policy::from_raw_mut(ptr) };
> +        T::adjust_perf(policy, min_perf, target_perf, capacity);
>      }
>  
>      /// Driver's `get_intermediate` callback.
> ---
> 
> Let me know what you think. If you think this is alright, I'll fold it
> into this same patch in the next version to preserve bisectiblity with
> CONFIG_RUST (or should I keep it separate?).
> 
> Since this is my first time dealing with the rust bindings, comments are
> highly appreciated.

Yeah looks fine. Just make sure it builds fine.

-- 
viresh
