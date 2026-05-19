Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3E52D8DB0
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 May 2026 01:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779154083; cv=none; b=gyjPciDhysGFE6PGjfcosfQajcMoQVnJvjfENauAKKED7yEiCpv8eTxQ/2p9PqDAcN2yW4Gq3087Rm2e0XAFDMuww06QJjvsLPswpVUuLCZjJNysyhe8jX1eo2xP24+y5iuBPzcq6i4tHR6Vgac4RCmfEq92CrTDFYTe7fFQb+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779154083; c=relaxed/simple;
	bh=XnRgLofZwqMGF0spCFn6L3eA/usJNna8SRhZyDrKHAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lrewfoosvIdNiwmWL8Prs4v7Qn0QxagpW8EgfKkrUbm4JmuPAbn1yik+p4ZK5HtJSQRmK++Cbt4HQQoP1BEynGReKmbz/botJgsBxOzi5ZYcNzj6qUQa8g8v4snx0BOjUQ4VDMnkLUqU2J6Yv/WOv004Yxy4unlwIVQjdkxiJkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOQck6Me; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOQck6Me"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso30320455e9.3
        for <linux-rt-devel@lists.linux.dev>; Mon, 18 May 2026 18:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779154079; x=1779758879; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zL+SFQRFZfYUjbIosBJ6WqJiHFVaURUa0YlMjzH/90c=;
        b=kOQck6MeUHZbq3hMTbKBT5Ct1SGncz/9HGXeIxI7ecOD2KQM7ecdnaSFGMtMSgmyag
         R9oM7YvtBvrOPSKP/5CyhTk/gLZ4TEme32MAzGu9GEF3sUwFF8DzQQ/I/qKJWpWAwGnw
         adpRt7BB/RmeNXjzUm390fSPyyTk3m4wyt5HoaH4w4SWXSqwcXDvIISJ6MZzNSUmVra4
         e9QdmiC9Mn6uzBexFCJdzKTkV5gNIhAzCgRfWZ+CS9/ZtDm4BXF7TSr29ou7krcEKIYt
         6VdNMN4jB9w+sKWJ6+BuwgNDCqDedUDubfpoXddFRVqBzj+MCNLu9VjrtAFVGTNBRA/k
         yffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779154079; x=1779758879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zL+SFQRFZfYUjbIosBJ6WqJiHFVaURUa0YlMjzH/90c=;
        b=bV8GoSKyRLIDbS8b7Pq8hZROASbxvFsEKE0LXeVJQYDUitIZOVcJ86VOJ7mLZnYLsk
         GK2mI/doIs5gdQCeX01Rz9xBVe6fJyep8I54L0UWvbUnfJN511UW2MYPMaBqmVin339i
         G/sQmSZOZpOAq1lKpYHOhdbQgX0Qqglv0u+iOVu7kZyPL4UopQZQ0QWUiFMhdjCMeb0k
         BMgV/1d+grxx4owpxAvz6QQjpewxMfY0o/isPY0BMMVxe4n91Bxz/Mavwhx7G/mendyS
         8u642vKx5u6GxuwR+n37/rYGscXfM2Cn3GE4Z7qaal2pJHnBa6AgqbWGbYULxbHk5s2i
         b0Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+oMovWK52gXR1ZcrG9VSpri1Jdf7L7L0qVQMYxVDiv4m62lHkrfPsRCflcxl6My4A3MnUQe5eJKpIVHePvpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz2bX2ZTdRb7JZFkNKq4lKiOfVGOO/Qp2/0V/CnLJ50RqgSlkro
	FZM0CeNQP3FIBqvFuPG91qFb6Di35H7idI1Qpbem5DAceRo8ljrG2P0c
X-Gm-Gg: Acq92OFJBMjYsm6lnU85dmyZvQxzlcta00b6mlMVvHru675LQgOX5H64YcVJ3au1AL9
	ONjHAe8SY/7Doc5VjZKXYJ3f8k4fUCrC7V7VfLJ+BodnZNTON0aD3u7DhPCLBFwhGNsJ0GJ39hh
	PvbxFwvSO+L8ZGmFXcSb0SoPjfbFi77b6IQkGPjCNf9PrrFPSt+IOocTDmfnPXZ0fTYkEUJeI+L
	aRiDknv2RS3QPCPqtQ8U73y1DJAj7aAQ6NM/SNCqqw3ux5IbRazkzBV1InzGW04YRYcQcu0UkPx
	3NZQNDoxthbJZGWPO5PQ3iaDdkX5EWv5pgMWC+VJWgtG35g++iG3EpWyGm1zwKzfFLiAcC6wDO6
	NRtllk5MIWYQax4xqrjE9o57PtISu+G6yvQM3u+I5b404TuzUAsitiuXeOcJmO9d4iWdkh4/Ywo
	ucc9a3Bl5riva1N7cfzqtqElFKvXBcoBRNbDCBEvQ5
X-Received: by 2002:a05:6000:22c5:b0:43d:6fb7:fedb with SMTP id ffacd0b85a97d-45e5c60a30cmr29018254f8f.36.1779154078288;
        Mon, 18 May 2026 18:27:58 -0700 (PDT)
Received: from WindFlash.powerhub ([2a0a:ef40:f83:8501:800:cd4:5e2:9556])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed2f738sm40548683f8f.16.2026.05.18.18.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:27:57 -0700 (PDT)
From: Leonardo Bras <leobras.c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Leonardo Bras <leobras.c@gmail.com>,
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
	Randy Dunlap <rdunlap@infradead.org>,
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
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Gary Guo <gary@garyguo.net>,
	Christian Brauner <brauner@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Coiby Xu <coxu@redhat.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-rt-devel@lists.linux.dev,
	Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH v4 1/4] Introducing pw_lock() and per-cpu queue & flush work
Date: Mon, 18 May 2026 22:27:47 -0300
Message-ID: <20260519012754.240804-2-leobras.c@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519012754.240804-1-leobras.c@gmail.com>
References: <20260519012754.240804-1-leobras.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21259; i=leobras.c@gmail.com; h=from:subject; bh=XnRgLofZwqMGF0spCFn6L3eA/usJNna8SRhZyDrKHAQ=; b=owGbwMvMwCX2pizjszvTwvWMp9WSGLK494SrzRddFdmwhWtN9AmdSUyFbGcM96isvCRjskR10 r2Ddw3XdJSyMIhxMciKKbLIPpq/iuf7lIwjV34sgJnDygQyhIGLUwAm8n8Swz/bo3GnndT3Zmdx 1Kw9IJUS8by3W+Fj8u0chybd6QHnev8xMuzeYP/NcvXpD9MXSBXec57NHCiqdHTaCemi2t+6EvP yZnIBAA==
X-Developer-Key: i=leobras.c@gmail.com; a=openpgp; fpr=36E6C95AE0F111CC5B6F4D2E688C33F8A0C5B0C5
Content-Transfer-Encoding: 8bit

Some places in the kernel implement a parallel programming strategy
consisting on local_locks() for most of the work, and some rare remote
operations are scheduled on target cpu. This keeps cache bouncing low since
cacheline tends to be mostly local, and avoids the cost of locks in non-RT
kernels, even though the very few remote operations will be expensive due
to scheduling overhead.

On the other hand, for RT workloads this can represent a problem:
scheduling work on remote cpu that are executing low latency tasks
is undesired and can introduce unexpected deadline misses.

It's interesting, though, that local_lock()s in RT kernels become
spinlock(). We can make use of those to avoid scheduling work on a remote
cpu by directly updating another cpu's per_cpu structure, while holding
it's spinlock().

In order to do that, it's necessary to introduce a new set of functions to
make it possible to get another cpu's per-cpu "local" lock (pw_{un,}lock*)
and also do the corresponding queueing (pw_queue_on()) and flushing
(pw_flush()) helpers to run the remote work.

Users of non-RT kernels but with low latency requirements can select
similar functionality by using the CONFIG_PWLOCKS compile time option.

On CONFIG_PWLOCKS disabled kernels, no changes are expected, as every
one of the introduced helpers work the exactly same as the current
implementation:
pw_{un,}lock*()		->  local_{un,}lock*() (ignores cpu parameter)
pw_queue_on()  		->  queue_work_on()
pw_flush()		->  flush_work()

For PWLOCKS enabled kernels, though, pw_{un,}lock*() will use the extra
cpu parameter to select the correct per-cpu structure to work on,
and acquire the spinlock for that cpu.

pw_queue_on() will just call the requested function in the current
cpu, which will operate in another cpu's per-cpu object. Since the
local_locks() become spinlock()s in PWLOCKS enabled kernels, we are
safe doing that.

pw_flush() then becomes a no-op since no work is actually scheduled on a
remote cpu.

Some minimal code rework is needed in order to make this mechanism work:
The calls for local_{un,}lock*() on the functions that are currently
scheduled on remote cpus need to be replaced by either pw_{un,}lock_*(),
PWLOCKS enabled kernels they can reference a different cpu. It's also
necessary to use a pw_struct instead of a work_struct, but it just
contains a work struct and, in CONFIG_PWLOCKS, the target cpu.

This should have almost no impact on non-CONFIG_PWLOCKS kernels: few
this_cpu_ptr() will become per_cpu_ptr(,smp_processor_id()) on non-hotpath
functions.

On CONFIG_PWLOCKS kernels, this should avoid deadlines misses by
removing scheduling noise.

Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
---
 MAINTAINERS                                   |   7 +
 .../admin-guide/kernel-parameters.txt         |  10 +
 Documentation/locking/pwlocks.rst             |  76 +++++
 init/Kconfig                                  |  35 +++
 kernel/Makefile                               |   2 +
 include/linux/pwlocks.h                       | 265 ++++++++++++++++++
 kernel/pwlocks.c                              |  47 ++++
 7 files changed, 442 insertions(+)
 create mode 100644 Documentation/locking/pwlocks.rst
 create mode 100644 include/linux/pwlocks.h
 create mode 100644 kernel/pwlocks.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d79275c6..7102031207c9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21775,20 +21775,27 @@ QORIQ DPAA2 FSL-MC BUS DRIVER
 M:	Ioana Ciornei <ioana.ciornei@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-bus-fsl-mc
 F:	Documentation/devicetree/bindings/misc/fsl,qoriq-mc.yaml
 F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
 
+PW Locks
+M:	Leonardo Bras <leobras.c@gmail.com>
+S:	Supported
+F:	Documentation/locking/pwlocks.rst
+F:	include/linux/pwlocks.h
+F:	kernel/pwlocks.c
+
 QT1010 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
 W:	https://linuxtv.org
 Q:	http://patchwork.linuxtv.org/project/linux-media/list/
 F:	drivers/media/tuners/qt1010*
 
 QUALCOMM ATH12K WIRELESS DRIVER
 M:	Jeff Johnson <jjohnson@kernel.org>
 L:	linux-wireless@vger.kernel.org
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..68c8a6f9d227 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2810,20 +2810,30 @@ Kernel parameters
 			  If a queue's affinity mask contains only isolated
 			  CPUs then this parameter has no effect on the
 			  interrupt routing decision, though interrupts are
 			  only delivered when tasks running on those
 			  isolated CPUs submit IO. IO submitted on
 			  housekeeping CPUs has no influence on those
 			  queues.
 
 			The format of <cpu-list> is described above.
 
+	pwlocks=	[KNL,SMP] Select a behavior on per-CPU resource sharing
+			and remote interference mechanism on a kernel built with
+			CONFIG_PWLOCKS.
+			Format: { "0" | "1" }
+			0 - local_lock() + queue_work_on(remote_cpu)
+			1 - spin_lock() for both local and remote operations
+
+			Selecting 1 may be interesting for systems that want
+			to avoid interruption & context switches from IPIs.
+
 	iucv=		[HW,NET]
 
 	ivrs_ioapic	[HW,X86-64]
 			Provide an override to the IOAPIC-ID<->DEVICE-ID
 			mapping provided in the IVRS ACPI table.
 			By default, PCI segment is 0, and can be omitted.
 
 			For example, to map IOAPIC-ID decimal 10 to
 			PCI segment 0x1 and PCI device 00:14.0,
 			write the parameter as:
diff --git a/Documentation/locking/pwlocks.rst b/Documentation/locking/pwlocks.rst
new file mode 100644
index 000000000000..09f4a5417bc1
--- /dev/null
+++ b/Documentation/locking/pwlocks.rst
@@ -0,0 +1,76 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========
+PW (Per-CPU Work) locks
+=========
+
+Some places in the kernel implement a parallel programming strategy
+consisting on local_locks() for most of the work, and some rare remote
+operations are scheduled on target cpu. This keeps cache bouncing low since
+cacheline tends to be mostly local, and avoids the cost of locks in non-RT
+kernels, even though the very few remote operations will be expensive due
+to scheduling overhead.
+
+On the other hand, for RT workloads this can represent a problem:
+scheduling work on remote cpu that are executing low latency tasks
+is undesired and can introduce unexpected deadline misses.
+
+PW locks help to convert sites that use local_locks (for cpu local operations)
+and queue_work_on (for queueing work remotely, to be executed
+locally on the owner cpu of the lock) to a spinlocks.
+
+The lock is declared pw_lock_t type.
+The lock is initialized with pw_lock_init.
+The lock is locked with pw_lock (takes a lock and cpu as a parameter).
+The lock is unlocked with pw_unlock (takes a lock and cpu as a parameter).
+
+The pw_lock_irqsave function disables interrupts and saves current interrupt state,
+cpu as a parameter.
+
+For trylock variant, there is the pw_trylock_t type, initialized with
+pw_trylock_init. Then the corresponding pw_trylock and pw_trylock_irqsave.
+
+work_struct should be replaced by pw_struct, which contains a cpu parameter
+(owner cpu of the lock), initialized by INIT_PW.
+
+The queue work related functions (analogous to queue_work_on and flush_work) are:
+pw_queue_on and pw_flush.
+
+The behaviour of the PW lock functions is as follows:
+
+* !CONFIG_PWLOCKS (or CONFIG_PWLOCKS and pwlocks=off kernel boot parameter):
+        - pw_lock:			local_lock
+        - pw_lock_irqsave:		local_lock_irqsave
+        - pw_trylock:			local_trylock
+        - pw_trylock_irqsave:		local_trylock_irqsave
+        - pw_unlock:			local_unlock
+        - pw_lock_local:		local_lock
+        - pw_trylock_local:		local_trylock
+        - pw_unlock_local:		local_unlock
+        - pw_queue_on:         		queue_work_on
+        - pw_flush:	            	flush_work
+
+* CONFIG_PWLOCKS (and CONFIG_PWLOCKS_DEFAULT=y or pwlocks=on kernel boot parameter),
+        - pw_lock:			spin_lock
+        - pw_lock_irqsave:		spin_lock_irqsave
+        - pw_trylock:			spin_trylock
+        - pw_trylock_irqsave:		spin_trylock_irqsave
+        - pw_unlock:			spin_unlock
+        - pw_lock_local:		preempt_disable OR migrate_disable + spin_lock
+        - pw_trylock_local:		preempt_disable OR migrate_disable + spin_trylock
+        - pw_unlock_local:		preempt_enable OR migrate_enable + spin_unlock
+        - pw_queue_on:         		executes work function on caller cpu
+        - pw_flush:            		empty
+
+pw_get_cpu(work_struct), to be called from within per-cpu work function,
+returns the target cpu.
+
+On the locking functions above, there are the local locking functions
+(pw_lock_local, pw_trylock_local and pw_unlock_local) that must only
+be used to access per-CPU data from the CPU that owns that data,
+and never remotely. They disable preemption/migration and don't require
+a cpu parameter, making them a replacement for local_lock functions that
+does not introduce overhead.
+
+These should only be used when accessing per-CPU data of the local CPU.
+
diff --git a/init/Kconfig b/init/Kconfig
index 2937c4d308ae..3fb751dc4530 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -764,20 +764,55 @@ config CPU_ISOLATION
 	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by
 	  any source of "noise" such as unbound workqueues, timers, kthreads...
 	  Unbound jobs get offloaded to housekeeping CPUs. This is driven by
 	  the "isolcpus=" boot parameter.
 
 	  Say Y if unsure.
 
+config PWLOCKS
+	bool "Per-CPU Work locks"
+	depends on SMP || COMPILE_TEST
+	default n
+	help
+	  Allow changing the behavior on per-CPU resource sharing with cache,
+	  from the regular local_locks() + queue_work_on(remote_cpu) to using
+	  per-CPU spinlocks on both local and remote operations.
+
+	  This is useful to give user the option on reducing IPIs to CPUs, and
+	  thus reduce interruptions and context switches. On the other hand, it
+	  increases generated code and will use atomic operations if spinlocks
+	  are selected.
+
+	  If set, will use the default behavior set in PWLOCKS_DEFAULT unless boot
+	  parameter pwlocks is passed with a different behavior.
+
+	  If unset, will use the local_lock() + queue_work_on() strategy,
+	  regardless of the boot parameter or PWLOCKS_DEFAULT.
+
+	  Say N if unsure.
+
+config PWLOCKS_DEFAULT
+	bool "Use per-CPU spinlocks by default on PWLOCKS"
+	depends on PWLOCKS
+	default n
+	help
+	  If set, will use per-CPU spinlocks as default behavior for per-CPU
+	  remote operations.
+
+	  If unset, will use local_lock() + queue_work_on(cpu) as default
+	  behavior for remote operations.
+
+	  Say N if unsure
+
 source "kernel/rcu/Kconfig"
 
 config IKCONFIG
 	tristate "Kernel .config support"
 	help
 	  This option enables the complete Linux kernel ".config" file
 	  contents to be saved in the kernel. It provides documentation
 	  of which kernel options are used in a running kernel or in an
 	  on-disk kernel.  This information can be extracted from the kernel
 	  image file with the script scripts/extract-ikconfig and used as
diff --git a/kernel/Makefile b/kernel/Makefile
index 6785982013dc..60ccad0699e7 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -135,20 +135,22 @@ obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
 
 obj-$(CONFIG_HAS_IOMEM) += iomem.o
 obj-$(CONFIG_RSEQ) += rseq.o
 obj-$(CONFIG_WATCH_QUEUE) += watch_queue.o
 
 obj-$(CONFIG_RESOURCE_KUNIT_TEST) += resource_kunit.o
 obj-$(CONFIG_SYSCTL_KUNIT_TEST) += sysctl-test.o
 
+obj-$(CONFIG_PWLOCKS) += pwlocks.o
+
 CFLAGS_kstack_erase.o += $(DISABLE_KSTACK_ERASE)
 CFLAGS_kstack_erase.o += $(call cc-option,-mgeneral-regs-only)
 obj-$(CONFIG_KSTACK_ERASE) += kstack_erase.o
 KASAN_SANITIZE_kstack_erase.o := n
 KCSAN_SANITIZE_kstack_erase.o := n
 KCOV_INSTRUMENT_kstack_erase.o := n
 
 obj-$(CONFIG_SCF_TORTURE_TEST) += scftorture.o
 
 $(obj)/configs.o: $(obj)/config_data.gz
diff --git a/include/linux/pwlocks.h b/include/linux/pwlocks.h
new file mode 100644
index 000000000000..3d79621655f9
--- /dev/null
+++ b/include/linux/pwlocks.h
@@ -0,0 +1,265 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PWLOCKS_H
+#define _LINUX_PWLOCKS_H
+
+#include "linux/spinlock.h"
+#include "linux/local_lock.h"
+#include "linux/workqueue.h"
+
+#ifndef CONFIG_PWLOCKS
+
+typedef local_lock_t pw_lock_t;
+typedef local_trylock_t pw_trylock_t;
+
+struct pw_struct {
+	struct work_struct work;
+};
+
+#define pw_lock_init(lock)				\
+	local_lock_init(lock)
+
+#define pw_trylock_init(lock)				\
+	local_trylock_init(lock)
+
+#define pw_lock(lock, cpu)				\
+	local_lock(lock)
+
+#define pw_lock_local(lock)				\
+	local_lock(lock)
+
+#define pw_lock_irqsave(lock, flags, cpu)		\
+	local_lock_irqsave(lock, flags)
+
+#define pw_lock_local_irqsave(lock, flags)		\
+	local_lock_irqsave(lock, flags)
+
+#define pw_trylock(lock, cpu)				\
+	local_trylock(lock)
+
+#define pw_trylock_local(lock)				\
+	local_trylock(lock)
+
+#define pw_trylock_irqsave(lock, flags, cpu)		\
+	local_trylock_irqsave(lock, flags)
+
+#define pw_unlock(lock, cpu)				\
+	local_unlock(lock)
+
+#define pw_unlock_local(lock)				\
+	local_unlock(lock)
+
+#define pw_unlock_irqrestore(lock, flags, cpu)		\
+	local_unlock_irqrestore(lock, flags)
+
+#define pw_unlock_local_irqrestore(lock, flags)		\
+	local_unlock_irqrestore(lock, flags)
+
+#define pw_lockdep_assert_held(lock)			\
+	lockdep_assert_held(lock)
+
+#define pw_queue_on(c, wq, pw)				\
+	queue_work_on(c, wq, &(pw)->work)
+
+#define pw_flush(pw)					\
+	flush_work(&(pw)->work)
+
+#define pw_get_cpu(pw)	smp_processor_id()
+
+#define pw_is_cpu_remote(cpu)		(false)
+
+#define INIT_PW(pw, func, c)				\
+	INIT_WORK(&(pw)->work, (func))
+
+#else /* CONFIG_PWLOCKS */
+
+DECLARE_STATIC_KEY_MAYBE(CONFIG_PWLOCKS_DEFAULT, pw_sl);
+
+typedef union {
+	spinlock_t sl;
+	local_lock_t ll;
+} pw_lock_t;
+
+typedef union {
+	spinlock_t sl;
+	local_trylock_t ll;
+} pw_trylock_t;
+
+struct pw_struct {
+	struct work_struct work;
+	int cpu;
+};
+
+#ifdef CONFIG_PREEMPT_RT
+#define preempt_or_migrate_disable migrate_disable
+#define preempt_or_migrate_enable migrate_enable
+#else
+#define preempt_or_migrate_disable preempt_disable
+#define preempt_or_migrate_enable preempt_enable
+#endif
+
+#define pw_lock_init(lock)							\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		spin_lock_init(lock.sl);					\
+	else									\
+		local_lock_init(lock.ll);					\
+} while (0)
+
+#define pw_trylock_init(lock)							\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		spin_lock_init(lock.sl);					\
+	else									\
+		local_trylock_init(lock.ll);					\
+} while (0)
+
+#define pw_lock(lock, cpu)							\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		spin_lock(per_cpu_ptr(lock.sl, cpu));				\
+	else									\
+		local_lock(lock.ll);						\
+} while (0)
+
+#define pw_lock_local(lock)							\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
+		preempt_or_migrate_disable();					\
+		spin_lock(this_cpu_ptr(lock.sl));				\
+	} else {								\
+		local_lock(lock.ll);						\
+	}									\
+} while (0)
+
+#define pw_lock_irqsave(lock, flags, cpu)					\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		spin_lock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);	\
+	else									\
+		local_lock_irqsave(lock.ll, flags);				\
+} while (0)
+
+#define pw_lock_local_irqsave(lock, flags)					\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
+		preempt_or_migrate_disable();					\
+		spin_lock_irqsave(this_cpu_ptr(lock.sl), flags);		\
+	} else {								\
+		local_lock_irqsave(lock.ll, flags);				\
+	}									\
+} while (0)
+
+#define pw_trylock(lock, cpu)							\
+({										\
+	int t;									\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		t = spin_trylock(per_cpu_ptr(lock.sl, cpu));			\
+	else									\
+		t = local_trylock(lock.ll);					\
+	t;									\
+})
+
+#define pw_trylock_local(lock)							\
+({										\
+	int t;									\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
+		preempt_or_migrate_disable();					\
+		t = spin_trylock(this_cpu_ptr(lock.sl));			\
+		if (!t)								\
+			preempt_or_migrate_enable();				\
+	} else {								\
+		t = local_trylock(lock.ll);					\
+	}									\
+	t;									\
+})
+
+#define pw_trylock_irqsave(lock, flags, cpu)					\
+({										\
+	int t;									\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		t = spin_trylock_irqsave(per_cpu_ptr(lock.sl, cpu), flags);	\
+	else									\
+		t = local_trylock_irqsave(lock.ll, flags);			\
+	t;									\
+})
+
+#define pw_unlock(lock, cpu)							\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		spin_unlock(per_cpu_ptr(lock.sl, cpu));			\
+	else									\
+		local_unlock(lock.ll);					\
+} while (0)
+
+#define pw_unlock_local(lock)							\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
+		spin_unlock(this_cpu_ptr(lock.sl));				\
+		preempt_or_migrate_enable();					\
+	} else {								\
+		local_unlock(lock.ll);						\
+	}									\
+} while (0)
+
+#define pw_unlock_irqrestore(lock, flags, cpu)					\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		spin_unlock_irqrestore(per_cpu_ptr(lock.sl, cpu), flags);	\
+	else									\
+		local_unlock_irqrestore(lock.ll, flags);			\
+} while (0)
+
+#define pw_unlock_local_irqrestore(lock, flags)					\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
+		spin_unlock_irqrestore(this_cpu_ptr(lock.sl), flags);	\
+		preempt_or_migrate_enable();					\
+	} else {								\
+		local_unlock_irqrestore(lock.ll, flags);			\
+	}									\
+} while (0)
+
+#define pw_lockdep_assert_held(lock)						\
+do {										\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		lockdep_assert_held(this_cpu_ptr(lock.sl));			\
+	else									\
+		lockdep_assert_held(this_cpu_ptr(lock.ll));			\
+} while (0)
+
+#define pw_queue_on(c, wq, pw)							\
+do {										\
+	int __c = c;								\
+	struct pw_struct *__pw = (pw);						\
+	if (static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl)) {		\
+		WARN_ON((__c) != __pw->cpu);					\
+		__pw->work.func(&__pw->work);					\
+	} else {								\
+		queue_work_on(__c, wq, &(__pw)->work);				\
+	}									\
+} while (0)
+
+/*
+ * Does nothing if PWLOCKS is set to use spinlock, as the task is already done at the
+ * time pw_queue_on() returns.
+ */
+#define pw_flush(pw)								\
+do {										\
+	struct pw_struct *__pw = (pw);						\
+	if (!static_branch_maybe(CONFIG_PWLOCKS_DEFAULT, &pw_sl))		\
+		flush_work(&__pw->work);					\
+} while (0)
+
+#define pw_get_cpu(w)			container_of((w), struct pw_struct, work)->cpu
+
+#define pw_is_cpu_remote(cpu)		((cpu) != smp_processor_id())
+
+#define INIT_PW(pw, func, c)							\
+do {										\
+	struct pw_struct *__pw = (pw);						\
+	INIT_WORK(&__pw->work, (func));						\
+	__pw->cpu = (c);							\
+} while (0)
+
+#endif /* CONFIG_PWLOCKS */
+#endif /* LINUX_PWLOCKS_H */
diff --git a/kernel/pwlocks.c b/kernel/pwlocks.c
new file mode 100644
index 000000000000..1ebf5cb979b9
--- /dev/null
+++ b/kernel/pwlocks.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "linux/export.h"
+#include <linux/sched.h>
+#include <linux/pwlocks.h>
+#include <linux/string.h>
+#include <linux/sched/isolation.h>
+
+DEFINE_STATIC_KEY_MAYBE(CONFIG_PWLOCKS_DEFAULT, pw_sl);
+EXPORT_SYMBOL(pw_sl);
+
+static bool pwlocks_param_specified;
+
+static int __init pwlocks_setup(char *str)
+{
+	int opt;
+
+	if (!get_option(&str, &opt)) {
+		pr_warn("PWLOCKS: invalid pwlocks parameter: %s, ignoring.\n", str);
+		return 0;
+	}
+
+	if (opt)
+		static_branch_enable(&pw_sl);
+	else
+		static_branch_disable(&pw_sl);
+
+	pwlocks_param_specified = true;
+
+	return 1;
+}
+__setup("pwlocks=", pwlocks_setup);
+
+/*
+ * Enable PWLOCKS if CPUs want to avoid kernel noise.
+ */
+static int __init pwlocks_init(void)
+{
+	if (pwlocks_param_specified)
+		return 0;
+
+	if (housekeeping_enabled(HK_TYPE_KERNEL_NOISE))
+		static_branch_enable(&pw_sl);
+
+	return 0;
+}
+
+late_initcall(pwlocks_init);
-- 
2.54.0

