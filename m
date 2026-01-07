Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C6224B1E
	for <linux-rt-devel@lists.linux.dev>; Wed,  7 Jan 2026 05:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767762512; cv=none; b=lj0UmDfY+2wBG42aipmBmSDwDtO3kTwkzA7dxIIr+gEiGLWI5oY00jpxDWuOFjJvSnohhpHn7XkHvi5z2MMKwWdzMB/YOXv8DKOyCHEV6LRUfwE0BtH+ltNUL8sztdN2RSp14uz2wb5xk/hIjufZ3HFX7F1ThOzVLhnyHJJp/kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767762512; c=relaxed/simple;
	bh=88qWZTn2mDcOSNE2vdWtCzUL/UvAo0squ4kmcbicKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TsMFxk6iFuBcs75fbwKlxqDe3GcCpCC623oNPcC5LgyaZ7c5URCL46B/6ICiV9e54M+0mOkQVz6HEzNgcLYJjNWlrFVG/psd2cgUXWi6ZW/Uq2On4LUNBcZoIhB7sgD3q91XDPIB75INe0mRi2odUjMq8MVzJmTRxRpnodBS/NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4+swAif; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4+swAif"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a09757004cso18314245ad.3
        for <linux-rt-devel@lists.linux.dev>; Tue, 06 Jan 2026 21:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767762510; x=1768367310; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=at4X6VqEFh529Zi30zW8MQksBOuqXFLRVDa3Tf7QCho=;
        b=E4+swAifVTxpCFL7rnSep/yAEKWWQ9gzAeUsNbIYGeJeBAuM9Rijl+1PQz4GsY+JQM
         KpvwPhLvgO7u0l+DlkPl5xmbsjpB4PjUc2jIl9oDgsIgZUlIzw2E0KrCrkeNEjQmtlO6
         UZOzri3sQ9uTqFRTnWKkzU/8dN9BYgGk1KdwK2MNVYMtTzqKZn+RJIS6xVMG5cklBa+W
         HVukrSuMgSC2ki2U/HHA8gKQFgFB8cFLveION7pCJogVuJ6qD1f5qREPEpM+qSKLsy0f
         p0cQh1ohsuMilGhzaziB6vIPiqD/C9Da9iwqSNrRgl+xGfCIzjI25gJaqLRksFZDTCN+
         74BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767762510; x=1768367310;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=at4X6VqEFh529Zi30zW8MQksBOuqXFLRVDa3Tf7QCho=;
        b=BKfpfuinpd4ZaOzTh2I4RsiL6TWvauBRfbEehsEmJznbK2Ukidm2UP/RKJk5e7R/5d
         8CrNXA6fS/CvKrUGE+0LRllXV822lEvQ8verjufUdbnVo9LEFLMV2quLs+FGVVHHdQUw
         jtc7xiU0HtJdbBNjJtURNN4gAJjO+FlGeHmW2UDw8GWlIz8S++cAKxxZrhw6et9GpIwA
         NwmpOmBiZUyvWYQdWnHPF0LuLBa1GdWWnU8+Aunq3jf7LrtUwiFoBcd6dQ7rMntcRHvH
         o+CumfejAdV3BFmrmIkxv1iwBxaE13wrNsjc+vJ9WI0eZNW+ZfV3A2u+yhJ/EBqdTKI7
         sZOg==
X-Forwarded-Encrypted: i=1; AJvYcCVufI09r9DJbW8epmRGoNu6zdvZ0gWxNlEBpdooTRN2OPGBQfWJuUBNoZ729gXHjbT47KNjsg0ljq5RmHgwAw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzKaXe+8l3kgbplXwKz1qNux459vVPCoyQCXMx6qV7hWxjo2dw
	ZZ3FXjTKPCQHTUuQ5zXpinUtVNWDGeF3p75NT3Kraj/YCEBClspScB92jDUTv+iIO94=
X-Gm-Gg: AY/fxX4nxzqFaZTreZ/ws2JexgKu/yySFW+gEs1ASILlVh57kVJErLOCrMAGoEkReZD
	o+12rniCEdgwwQw87yRnYxiczUd6SRkDUJh2uK4fUqOsT3Dt338AcZ63HbvQVbUiH+p1XCyEQyv
	N7AotGM/Vwle9W6fitHOy3nuO+mzf0D8hup2FnKv9GWdsKiwHqSFWsybw7EYUTQ35bC0IfYLeqj
	Tb/kwEOWeCbPcHEvC0eOVMcpF2tILtFHs5ZO1LTzvxgA0PNRdChQ8p0T8ocq8idIymdJxwFfhiJ
	N3CiF/7oCTo7tSzGVNQtJ3uwi813o/9uoVX50sNozwNFw0MLFwqpJsM78Q+Dh0N9PhK27qyVOcB
	fjyLbeUS+rUac9r1WL8b6tdE6oDYX1zwRumgPWaNGVhgewjtwref8uwOCMP1EKk0pXkkNE0l1cv
	0MK9yZgFu2y0U=
X-Google-Smtp-Source: AGHT+IE6DIWAPI6xhj/dvOFpGf1N/JyjFHBr3QBR1usdNPYk3+KTAjPz87Md2+NySEM8eS1qf1OW+A==
X-Received: by 2002:a17:903:2341:b0:2a0:a09b:7b0 with SMTP id d9443c01a7336-2a3ee4c456amr10088815ad.61.1767762510009;
        Tue, 06 Jan 2026 21:08:30 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a560sm36452645ad.21.2026.01.06.21.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 21:08:29 -0800 (PST)
Date: Wed, 7 Jan 2026 10:38:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Clark Williams <clrkwllms@kernel.org>, Bert Karwatzki <spasswolf@web.de>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, Perry Yuan <perry.yuan@amd.com>
Subject: Re: [RFC PATCH 0/2] cpufreq/amd-pstate: Prevent scheduling when
 atomic on PREEMPT_RT
Message-ID: <oeyvz6463yujz63q4ijqsoobvaudtjymrokgb7jesa537vi7ds@jx5c6bgokwx7>
References: <20260106073608.278644-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260106073608.278644-1-kprateek.nayak@amd.com>

On 06-01-26, 07:36, K Prateek Nayak wrote:
> Bert reported hitting "BUG: scheduling while atomic" when running
> amd-pstate-ut on a PREEMPT_RT kernel [1].
> 
> Since reader-writer locks turn sleepable on PREEMPT_RT, they are not
> suitable to be used in the scheduler hot-path under rq_lock to grab the
> cpufreq policy object.
> 
> Unfortunately, the amd-pstate driver has a tight coupling between the
> cpufreq_policy object and the cpudata stored in it as the driver_data.
> 
> Trying to grab a read reference on PREEMPT_RT can cause "scheduling
> while atomic" if a concurrent writer is active, and trying to grab a
> nested reference in presence of a writer can cause a deadlock (manifests
> as lockup) since the reader fast-path is disabled on PREEMPT_RT to
> prevent write-side starvation.
> 
> The two patches included removes cases of grabbing a nested read
> reference to the cpufreq policy in amd-pstate, and modifies the
> cpufreq_driver->adjust_perf() callback to take the raw policy reference
> cached by the schedutil governor respectively.
> 
> The policy object outlives the governor and the driver making it safe to
> use this cache reference from the sugov data. Any changes to the policy
> will end up calling cpufreq_driver->set_policy() or
> governor->set_limits() once the policy is modified which should ensure
> eventual consistency despite not holding the read-side.
> 
> Series has been tested with amd-pstate-ut on PREEMPT_RT kernel which
> successfully passes without any splats on LOCKDEP + DEBUG_ATOMIC_SLEEP
> config. Additionally, the driver switch test from Gautham [2] was run
> for 10min on the same config without observing any splats.
> 
> [1] https://lore.kernel.org/all/20250731092316.3191-1-spasswolf@web.de/
> [2] https://lore.kernel.org/all/aJRN2wMLAnhDFykv@BLRRASHENOY1.amd.com/

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
