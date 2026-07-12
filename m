Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122112FFF89
	for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783891391; cv=none; b=PbHfGIq6TtivwM1kR5nYINQMp7M0wdlrN4PMGwb9V6pDh8v9sKwKun7Pb85UQowWYePQRwcgwpJRVlKMstITWerhOOTOc4k2Et+A/IJIFe+KGalhAX4zj3sIM66TvU3H62WSFkiO61HVP0VwQkWeyD44LkFKVSTjV/TtVPiGpsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783891391; c=relaxed/simple;
	bh=uq2LxliGBRPTNUdXlsaJF47jC+6soJ82ARALMRXUVQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=o9cWCPv8zhaT5ZfcVc9Q9Az3oN57mEpxTVd2wfkhKQUBn7+HRye5Nk1zWF5tbwbR1yK3iI9gfQIlo+W7vFgqe3+7BwedzdLyuJfHSV1pCpidU2xRxaDhpRJEQcyvU6uH6Lf/+xHayKLF9EzVS+EJrVG/3XdfK0LSS5D//hg6Tfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9hyeZK8; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9hyeZK8"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47db714766aso1700204f8f.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 12 Jul 2026 14:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783891387; x=1784496187; darn=lists.linux.dev;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0possHhbYWMvozQHF1jT+xcy8ymwyLPGUVqKNvmfdh8=;
        b=C9hyeZK8CHDL5wqzCmk33hd67SwGU+mS/Tdl3sZ0pIwDpYUvnhU+n/WlCADgHSshpD
         moWwGmmwtai5wL+fu2HomwO3vgPcnNbYfzUtVItbapx6maWEtXwsJml9G6QTSAZOkWF/
         SJR5vo3DGdJuiv1kis0CURwQtUu+NUB1O3zlAMqqKr/6YqN47Vj1b9D0IsWPXTcaFG4R
         oP9QbFubpLmLN5JFE7dMcTclMHZcDPDrDwPF5q7M0/LMd44XBj/cXbdWLipL0NhTD09i
         lGSpiBvaNzSYsEv2ElTV3gqP0tVW3vZBi8zCVpFgPVBBcBYc+ocdwOQxaz+wKgD1s4D0
         /R7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783891387; x=1784496187;
        h=content-transfer-encoding:content-disposition:content-type
         :mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0possHhbYWMvozQHF1jT+xcy8ymwyLPGUVqKNvmfdh8=;
        b=Iw32rFrTSO/c04upjUsxCCWawnmnGbLOGRmx5ljcuejKE1jctO0h3auicIVVo6sdbZ
         gaVVTSn22FAtgefBCXr3da09QuDnZHywE5rsBETfCwQD/l2Hp7Sqwr5Kb68PXZQ1Lfux
         ZkdW+HDP6Yj8DqPfHGTicXO3PDvopEY4AVzo7NHxbVe4xqzVKLmGcK/1BXjmFglylaSk
         OBaI0hGbIA6avjgXlAJFWHjBIQf6W92hod2boDevlkY5YSgwcyz3/u4pgST4uuDe79Ti
         2jr8tu2fCBa7KUDpBFzDnUcoFmJ1RVhYiQCVwxOpu76hu8Tz/dvEhr4xXrWNS3ysepSu
         FisA==
X-Forwarded-Encrypted: i=1; AHgh+Rp1PLQP7xb8PMAMEXYWuJRTGzvCo6wqu4uaBDZtrF5ftUJaFvRrxDyRSakd+qiUhOEuG6r6BF/XvM1nz39tCw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yww2I4VoneuPk63FOFmf3lY55SJ1729S8r4TecbexepzMWTXc9g
	pdZDCLRqgoTN+qNjigIobHGS41/T7pBy5vh7l/9xFzrRP0U5PwViwGEz
X-Gm-Gg: AfdE7cm9LKmTkLwwlJ1VPHQrLRnzfvSRaPhHf6Bz8mnsXgu7hB+iMLGuwSc25rkl/yr
	YL3xgYwe+7NF3aHHO/z70PsjMZ+g3oW0hSaCcmvBMS0SHcYhIRXr/ajUhY0wagilfq56RpgHrBq
	93yt0wvExiuxAfTx45WHZCAVLYZLUioPG7lFMYoybK+1ZgrpVejWPa/kW2iI1RhGodHImC8PP9I
	pIrlsqQ7XQoZ52bOq2Hhjdd9wibT2vwayImDqRLB+5yML7XbSkDRk1sWlxrq9bg1NSjV62pFFdB
	csX5AJgJeBP3o4Au7ECb6UWqNu3BcoOJQmVfbUSLedorxDCnaltuWMmNP/5n1+iCVXeyH0MbfM0
	mp1CQ9yqtsQZcEKnZBpPFsNckOmW/24tUzgbRIM8VpNuYN6uXjaxTljQXUI7C6wODHWjInlrxT3
	8iouulJE9e2fRG+oFy0BShvA==
X-Received: by 2002:a05:6000:22ca:b0:47e:4379:a4ed with SMTP id ffacd0b85a97d-47f2dcd9e36mr7905011f8f.30.1783891387132;
        Sun, 12 Jul 2026 14:23:07 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f61:3b01:d08a:833b:756:8fce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm80813963f8f.26.2026.07.12.14.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 14:23:06 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Leonardo Bras <leobras.c@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush work
Date: Sun, 12 Jul 2026 18:23:04 -0300
Message-ID: <alQFuIPKRjQ_vjmg@WindFlash>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <fec6554d-3639-4c27-9a14-3d3914c51588@infradead.org>
References: <20260519012754.240804-1-leobras.c@gmail.com> <20260519012754.240804-2-leobras.c@gmail.com> <fec6554d-3639-4c27-9a14-3d3914c51588@infradead.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 20, 2026 at 03:06:30PM -0700, Randy Dunlap wrote:
> 
> 
> On 5/18/26 6:27 PM, Leonardo Bras wrote:
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index c2c6d79275c6..7102031207c9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -21775,20 +21775,27 @@ QORIQ DPAA2 FSL-MC BUS DRIVER
> >  M:	Ioana Ciornei <ioana.ciornei@nxp.com>
> >  L:	linuxppc-dev@lists.ozlabs.org
> >  L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
> >  F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
> >  F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
> >  F:	drivers/bus/fsl-mc/
> >  F:	include/uapi/linux/fsl_mc.h
> >  
> > +PW Locks
> > +M:	Leonardo Bras <leobras.c@gmail.com>
> > +S:	Supported
> > +F:	Documentation/locking/pwlocks.rst
> > +F:	include/linux/pwlocks.h
> > +F:	kernel/pwlocks.c
> 
> MAINTAINERS entries should be in alphabetical order: PW is not in the
> middle of the Q entries.

Hi Randy, thank you for reviewing!

Argh, sorry, it used to be called QPW. I renamed and forgot to reorder.

> 
> > +
> >  QT1010 MEDIA DRIVER
> >  L:	linux-media@vger.kernel.org
> >  S:	Orphan
> >  W:	https://linuxtv.org
> >  Q:	http://patchwork.linuxtv.org/project/linux-media/list/
> >  F:	drivers/media/tuners/qt1010*
> >  
> >  QUALCOMM ATH12K WIRELESS DRIVER
> >  M:	Jeff Johnson <jjohnson@kernel.org>
> >  L:	linux-wireless@vger.kernel.org
> 
> 
> > diff --git a/Documentation/locking/pwlocks.rst b/Documentation/locking/pwlocks.rst
> > new file mode 100644
> > index 000000000000..09f4a5417bc1
> > --- /dev/null
> > +++ b/Documentation/locking/pwlocks.rst
> > @@ -0,0 +1,76 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +=========
> > +PW (Per-CPU Work) locks
> > +=========
> 
> Overline and underline should be at least as long as the heading text.
>

Noted!
 
> > +
> > +Some places in the kernel implement a parallel programming strategy
> > +consisting on local_locks() for most of the work, and some rare remote
> > +operations are scheduled on target cpu. This keeps cache bouncing low since
> 
>                             on a target CPU.

Right

> 
> > +cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > +kernels, even though the very few remote operations will be expensive due
> > +to scheduling overhead.
> > +
> > +On the other hand, for RT workloads this can represent a problem:
> > +scheduling work on remote cpu that are executing low latency tasks
> 
>                              CPUs

Will fix


> 
> > +is undesired and can introduce unexpected deadline misses.
> 
>       undesirable
> ?

Yes

> 
> > +
> > +PW locks help to convert sites that use local_locks (for cpu local operations)
> > +and queue_work_on (for queueing work remotely, to be executed
> > +locally on the owner cpu of the lock) to a spinlocks.
> 
>                                          to spinlocks.
> 

Right

> > +
> > +The lock is declared pw_lock_t type.
> > +The lock is initialized with pw_lock_init.
> > +The lock is locked with pw_lock (takes a lock and cpu as a parameter).
> > +The lock is unlocked with pw_unlock (takes a lock and cpu as a parameter).
> > +
> > +The pw_lock_irqsave function disables interrupts and saves current interrupt state,
> > +cpu as a parameter.
> > +
> > +For trylock variant, there is the pw_trylock_t type, initialized with
> > +pw_trylock_init. Then the corresponding pw_trylock and pw_trylock_irqsave.
> > +
> > +work_struct should be replaced by pw_struct, which contains a cpu parameter
> > +(owner cpu of the lock), initialized by INIT_PW.
> > +
> > +The queue work related functions (analogous to queue_work_on and flush_work) are:
> > +pw_queue_on and pw_flush.
> > +
> > +The behaviour of the PW lock functions is as follows:
> > +
> > +* !CONFIG_PWLOCKS (or CONFIG_PWLOCKS and pwlocks=off kernel boot parameter):
> > +        - pw_lock:			local_lock
> > +        - pw_lock_irqsave:		local_lock_irqsave
> > +        - pw_trylock:			local_trylock
> > +        - pw_trylock_irqsave:		local_trylock_irqsave
> > +        - pw_unlock:			local_unlock
> > +        - pw_lock_local:		local_lock
> > +        - pw_trylock_local:		local_trylock
> > +        - pw_unlock_local:		local_unlock
> > +        - pw_queue_on:         		queue_work_on
> > +        - pw_flush:	            	flush_work
> > +
> > +* CONFIG_PWLOCKS (and CONFIG_PWLOCKS_DEFAULT=y or pwlocks=on kernel boot parameter),
> > +        - pw_lock:			spin_lock
> > +        - pw_lock_irqsave:		spin_lock_irqsave
> > +        - pw_trylock:			spin_trylock
> > +        - pw_trylock_irqsave:		spin_trylock_irqsave
> > +        - pw_unlock:			spin_unlock
> > +        - pw_lock_local:		preempt_disable OR migrate_disable + spin_lock
> > +        - pw_trylock_local:		preempt_disable OR migrate_disable + spin_trylock
> > +        - pw_unlock_local:		preempt_enable OR migrate_enable + spin_unlock
> > +        - pw_queue_on:         		executes work function on caller cpu
> > +        - pw_flush:            		empty
> > +
> > +pw_get_cpu(work_struct), to be called from within per-cpu work function,
> > +returns the target cpu.
> 
>                       CPU.
> 

Will fix

> > +
> > +On the locking functions above, there are the local locking functions
> > +(pw_lock_local, pw_trylock_local and pw_unlock_local) that must only
> > +be used to access per-CPU data from the CPU that owns that data,
> > +and never remotely. They disable preemption/migration and don't require
> > +a cpu parameter, making them a replacement for local_lock functions that
> > +does not introduce overhead.
> > +
> > +These should only be used when accessing per-CPU data of the local CPU.
> > +
> 
> Running "make htmldocs" with this patch says:
> 
> Documentation/locking/pwlocks.rst: WARNING: document isn't included in any toctree [toc.not_included]
> 

Humm, I will figure out a way of including it in a relevant toctree.

> > diff --git a/init/Kconfig b/init/Kconfig
> > index 2937c4d308ae..3fb751dc4530 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -764,20 +764,55 @@ config CPU_ISOLATION
> >  	depends on SMP
> >  	default y
> >  	help
> >  	  Make sure that CPUs running critical tasks are not disturbed by
> >  	  any source of "noise" such as unbound workqueues, timers, kthreads...
> >  	  Unbound jobs get offloaded to housekeeping CPUs. This is driven by
> >  	  the "isolcpus=" boot parameter.
> >  
> >  	  Say Y if unsure.
> >  
> > +config PWLOCKS
> > +	bool "Per-CPU Work locks"
> > +	depends on SMP || COMPILE_TEST
> > +	default n
> > +	help
> > +	  Allow changing the behavior on per-CPU resource sharing with cache,
> > +	  from the regular local_locks() + queue_work_on(remote_cpu) to using
> > +	  per-CPU spinlocks on both local and remote operations.
> > +
> > +	  This is useful to give user the option on reducing IPIs to CPUs, and
> 
> 	                 to give the user

Right

> 
> > +	  thus reduce interruptions and context switches. On the other hand, it
> > +	  increases generated code and will use atomic operations if spinlocks
> > +	  are selected.
> > +
> > +	  If set, will use the default behavior set in PWLOCKS_DEFAULT unless boot
> 
> 	                                                               unless the boot
> 

Correct

> > +	  parameter pwlocks is passed with a different behavior.
> > +
> > +	  If unset, will use the local_lock() + queue_work_on() strategy,
> > +	  regardless of the boot parameter or PWLOCKS_DEFAULT.
> > +
> > +	  Say N if unsure.
> > +
> > +config PWLOCKS_DEFAULT
> > +	bool "Use per-CPU spinlocks by default on PWLOCKS"
> > +	depends on PWLOCKS
> > +	default n
> > +	help
> > +	  If set, will use per-CPU spinlocks as default behavior for per-CPU
> > +	  remote operations.
> > +
> > +	  If unset, will use local_lock() + queue_work_on(cpu) as default
> > +	  behavior for remote operations.
> > +
> > +	  Say N if unsure
> 
> 	           unsure.
> 

Yeap :)

> > +
> >  source "kernel/rcu/Kconfig"
> >  
> >  config IKCONFIG
> >  	tristate "Kernel .config support"
> >  	help
> >  	  This option enables the complete Linux kernel ".config" file
> >  	  contents to be saved in the kernel. It provides documentation
> >  	  of which kernel options are used in a running kernel or in an
> >  	  on-disk kernel.  This information can be extracted from the kernel
> >  	  image file with the script scripts/extract-ikconfig and used as
> 
> -- 
> ~Randy
> 


Thanks!
Leo
