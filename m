Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522BA2F90FE
	for <linux-rt-devel@lists.linux.dev>; Fri, 15 Aug 2025 09:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755250749; cv=none; b=N0oUAYphx1IOeMtLZtR5APeUQPFpe/6XX67zKCidWyS8Nfq1Q5xuibrHWjXqsHB3dgtPanMKwHsg+4it5UaAmrbjGOn23QI5uJGf4TMTRaVJnDZ7IrhKHl7rn1dpcuIVgldVElwktkdSeP9Z3sukkqUipkCtSE7/Y7ZIP81vwew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755250749; c=relaxed/simple;
	bh=KryXtE3oAonj7UQvSxvhNGwY8saqJR4GHRjN0bvRIYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+p3Kah+OFCeR1i62q2gzELlzjeqR+YuZcTHY/BOsGnIbsBB06OqyhupBfzKh9VSR0U0kEYPUdbs+pt8HynDQ3UkEPXuliw0kgmYcRpLQkbI3ZLshSB8uUzZcApi0LIIk2oVTQZVX71Xvx5MJNa17lkb56qsOBK8gjZAbEZNKsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x7Jiu+XV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oRsuEjfL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x7Jiu+XV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oRsuEjfL"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755250744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMwdO0q4tsDVB2uQM1KTUxdLGZ9JaIWyMgJGjcflga4=;
	b=x7Jiu+XVIx88BJUVpuVM81N8RLt+8qwiwiOOW6lb5sGz7OvZWBR8bocEv9Do0ddbGbEsbH
	1KA88Hkn9r3ThI91C1ut6eH2J8aQkUJJTvhW+mVp8fNOBN3lIuTp1SOn+Zo5WqY7l8NbvJ
	HDegHETP4bycx1bWj/sN+bWxEbCAeIMZ6+6nNWO0J399KBDo9i8HpriLGptWlEY/MxzLrQ
	GCZkoWUMXlSuic83ZjAzncgjPhWdIUi2G0sYkBJvCvBTb3gPfMxyZQKRcw7splaiI/BGyI
	GXKqstHFQZodkdmy76BQyhfLs13kIKEv+RMDMif0dZNorjwju4cJ3FSjCriRng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755250744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eMwdO0q4tsDVB2uQM1KTUxdLGZ9JaIWyMgJGjcflga4=;
	b=oRsuEjfLeu8hkNGuXpGk4p9pZORyUunlFdcgS06MlfIQ0ZgQw0l4VwxL/TqZ99WJbnJrbS
	NlQFmbxbIV6p+0DA==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/3] Documentation: Add real-time to core-api
Date: Fri, 15 Aug 2025 11:38:57 +0200
Message-ID: <20250815093858.930751-4-bigeasy@linutronix.de>
In-Reply-To: <20250815093858.930751-1-bigeasy@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The documents explain the design concepts behind PREEMPT_RT and highlight k=
ey
differences necessary to achieve it.
It also include a list of requirements that must be fulfilled to support
PREEMPT_RT on a given architecture.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/core-api/index.rst              |   1 +
 .../real-time/architecture-porting.rst        | 109 ++++++++
 .../core-api/real-time/differences.rst        | 242 ++++++++++++++++++
 Documentation/core-api/real-time/index.rst    |  16 ++
 Documentation/core-api/real-time/theory.rst   | 116 +++++++++
 5 files changed, 484 insertions(+)
 create mode 100644 Documentation/core-api/real-time/architecture-porting.r=
st
 create mode 100644 Documentation/core-api/real-time/differences.rst
 create mode 100644 Documentation/core-api/real-time/index.rst
 create mode 100644 Documentation/core-api/real-time/theory.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/inde=
x.rst
index a03a99c2cac56..6cbdcbfa79c30 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -24,6 +24,7 @@ it.
    printk-index
    symbol-namespaces
    asm-annotations
+   real-time/index
=20
 Data structures and low-level utilities
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
diff --git a/Documentation/core-api/real-time/architecture-porting.rst b/Do=
cumentation/core-api/real-time/architecture-porting.rst
new file mode 100644
index 0000000000000..d822fac29922d
--- /dev/null
+++ b/Documentation/core-api/real-time/architecture-porting.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Porting an architecture to support PREEMPT_RT
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+This list outlines the architecture specific requirements that must be
+implemented in order to enable PREEMPT_RT. Once all required features are
+implemented, ARCH_SUPPORTS_RT can be selected in architecture=E2=80=99s Kc=
onfig to make
+PREEMPT_RT selectable.
+Many prerequisites (genirq support for example) are enforced by the common=
 code
+and are omitted here.
+
+The optional features are not strictly required but it is worth to consider
+them.
+
+Requirements
+------------
+
+Forced threaded interrupts
+  CONFIG_IRQ_FORCED_THREADING must be selected. Any interrupts that must
+  remain in hard-IRQ context must be marked with IRQF_NO_THREAD. This
+  requirement applies for instance to clocksource event interrupts,
+  perf interrupts and cascading interrupt-controller handlers.
+
+PREEMPTION support
+  Kernel preemption must be supported and requires that
+  CONFIG_ARCH_NO_PREEMPT remain unselected. Scheduling requests, such as t=
hose
+  issued from an interrupt or other exception handler, must be processed
+  immediately.
+
+POSIX CPU timers and KVM
+  POSIX CPU timers must expire from thread context rather than directly wi=
thin
+  the timer interrupt. This behavior is enabled by setting the configurati=
on
+  option CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK.
+  When KVM is enabled, CONFIG_KVM_XFER_TO_GUEST_WORK must also be set to e=
nsure
+  that any pending work, such as POSIX timer expiration, is handled before
+  transitioning into guest mode.
+
+Hard-IRQ and Soft-IRQ stacks
+  Soft interrupts are handled in the thread context in which they are rais=
ed. If
+  a soft interrupt is triggered from hard-IRQ context, its execution is de=
ferred
+  to the ksoftirqd thread. Preemption is never disabled during soft interr=
upt
+  handling, which makes soft interrupts preemptible.
+  If an architecture provides a custom __do_softirq() implementation that =
uses a
+  separate stack, it must select CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK. The
+  functionality should only be enabled when CONFIG_SOFTIRQ_ON_OWN_STACK is=
 set.
+
+FPU and SIMD access in kernel mode
+  FPU and SIMD registers are typically not used in kernel mode and are the=
refore
+  not saved during kernel preemption. As a result, any kernel code that us=
es
+  these registers must be enclosed within a kernel_fpu_begin() and
+  kernel_fpu_end() section.
+  The kernel_fpu_begin() function usually invokes local_bh_disable() to pr=
event
+  interruptions from softirqs and to disable regular preemption. This allo=
ws the
+  protected code to run safely in both thread and softirq contexts.
+  On PREEMPT_RT kernels, however, kernel_fpu_begin() must not call
+  local_bh_disable(). Instead, it should use preempt_disable(), since soft=
irqs
+  are always handled in thread context under PREEMPT_RT. In this case, dis=
abling
+  preemption alone is sufficient.
+  The crypto subsystem operates on memory pages and requires users to "wal=
k and
+  map" these pages while processing a request. This operation must occur o=
utside
+  the kernel_fpu_begin()/ kernel_fpu_end() section because it requires pre=
emption
+  to be enabled. These preemption points are generally sufficient to avoid
+  excessive scheduling latency.
+
+Exception handlers
+  Exception handlers, such as the page fault handler, typically enable int=
errupts
+  early, before invoking any generic code to process the exception. This is
+  necessary because handling a page fault may involve operations that can =
sleep.
+  Enabling interrupts is especially important on PREEMPT_RT, where certain
+  locks, such as spinlock_t, become sleepable. For example, handling an
+  invalid opcode may result in sending a SIGILL signal to the user task. A
+  debug excpetion will send a SIGTRAP signal.
+  In both cases, if the exception occurred in user space, it is safe to en=
able
+  interrupts early. Sending a signal requires both interrupts and kernel
+  preemption to be enabled.
+
+Optional features
+-----------------
+
+Timer and clocksource
+  A high-resolution clocksource and clockevents device are recommended. The
+  clockevents device should support the CLOCK_EVT_FEAT_ONESHOT feature for
+  optimal timer behavior. In most cases, microsecond-level accuracy is
+  sufficient
+
+Lazy preemption
+  This mechanism allows an in-kernel scheduling request for non-real-time =
tasks
+  to be delayed until the task is about to return to user space. It helps =
avoid
+  preempting a task that holds a sleeping lock at the time of the scheduli=
ng
+  request.
+  With CONFIG_GENERIC_IRQ_ENTRY enabled, supporting this feature requires
+  defining a bit for TIF_NEED_RESCHED_LAZY, preferably near TIF_NEED_RESCH=
ED.
+
+Serial console with NBCON
+  With PREEMPT_RT enabled, all console output is handled by a dedicated th=
read
+  rather than directly from the context in which printk() is invoked. This=
 design
+  allows printk() to be safely used in atomic contexts.
+  However, this also means that if the kernel crashes and cannot switch to=
 the
+  printing thread, no output will be visible preventing the system from pr=
inting
+  its final messages.
+  There are exceptions for immediate output, such as during panic() handli=
ng. To
+  support this, the console driver must implement new-style lock handling.=
 This
+  involves setting the CON_NBCON flag in console::flags and providing
+  implementations for the write_atomic, write_thread, device_lock, and
+  device_unlock callbacks.
diff --git a/Documentation/core-api/real-time/differences.rst b/Documentati=
on/core-api/real-time/differences.rst
new file mode 100644
index 0000000000000..50d994a31e11c
--- /dev/null
+++ b/Documentation/core-api/real-time/differences.rst
@@ -0,0 +1,242 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Significant differences
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+Preface
+=3D=3D=3D=3D=3D=3D=3D
+
+With forced-threaded interrupts and sleeping spin locks, code paths that
+previously caused long scheduling latencies have been made preemptible and
+moved into process context. This allows the scheduler to manage them more
+effectively and respond to higher-priority tasks with reduced latency.
+
+The following chapters provide an overview of key differences between a
+PREEMPT_RT kernel and a standard, non-PREEMPT_RT kernel.
+
+Locking
+=3D=3D=3D=3D=3D=3D=3D
+
+Spinning locks such as spinlock_t are used to provide synchronization for =
data
+structures accessed from both interrupt context and process context. For t=
his
+reason, locking functions are also available with the _irq() or _irqsave()
+suffixes, which disable interrupts before acquiring the lock. This ensures=
 that
+the lock can be safely acquired in process context when interrupts are ena=
bled.
+
+However, on a PREEMPT_RT system, interrupts are forced-threaded and no lon=
ger
+run in hard IRQ context. As a result, there is no need to disable interrup=
ts as
+part of the locking procedure when using spinlock_t.
+
+For low-level core components such as interrupt handling, the scheduler, o=
r the
+timer subsystem the kernel uses raw_spinlock_t. This lock type preserves
+traditional semantics: it disables preemption and, when used with _irq() or
+_irqsave(), also disables interrupts. This ensures proper synchronization =
in
+critical sections that must remain non-preemptible or with interrupts disa=
bled.
+
+Execution context
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Interrupt handling in a PREEMPT_RT system is invoked in process context th=
rough
+the use of threaded interrupts. Other parts of the kernel also shift their
+execution into threaded context by different mechanisms. The goal is to ke=
ep
+execution paths preemptible, allowing the scheduler to interrupt them when=
 a
+higher-priority task needs to run.
+
+Below is an overview of the kernel subsystems involved in this transition =
to
+threaded, preemptible execution.
+
+Interrupt handling
+------------------
+
+All interrupts are forced-threaded in a PREEMPT_RT system. The exceptions =
are
+interrupts that are requested with the IRQF_NO_THREAD, IRQF_PERCPU, or
+IRQF_ONESHOT flags.
+
+The IRQF_ONESHOT flag is used together with threaded interrupts, meaning t=
hose
+registered using request_threaded_irq() and providing only a threaded hand=
ler.
+Its purpose is to keep the interrupt line masked until the threaded handle=
r has
+completed.
+
+If a primary handler is also provided in this case, it is essential that t=
he
+handler does not acquire any sleeping locks, as it will not be threaded. T=
he
+handler should be minimal and must avoid introducing delays, such as
+busy-waiting on hardware registers.
+
+
+Soft interrupts, bottom half handling
+-------------------------------------
+
+Soft interrupts are raised by the interrupt handler and are executed after=
 the
+handler returns. Since they run in thread context, they can be preempted by
+other threads. Do not assume that softirq context runs with preemption
+disabled. This means you must not rely on mechanisms like local_bh_disable=
() in
+process context to protect per-CPU variables. Because softirq handlers are
+preemptible under PREEMPT_RT, this approach does not provide reliable
+synchronization.
+
+If this kind of protection is required for performance reasons, consider u=
sing
+local_lock_nested_bh(). On non-PREEMPT_RT kernels, this allows lockdep to
+verify that bottom halves are disabled. On PREEMPT_RT systems, it adds the
+necessary locking to ensure proper protection.
+
+Using local_lock_nested_bh() also makes the locking scope explicit and eas=
ier
+for readers and maintainers to understand.
+
+
+per-CPU variables
+-----------------
+
+Protecting access to per-CPU variables solely by using preempt_disable() s=
hould
+be avoided, especially if the critical section has unbounded runtime or may
+call APIs that can sleep.
+
+If using a spinlock_t is considered too costly for performance reasons,
+consider using local_lock_t. On non-PREEMPT_RT configurations, this introd=
uces
+no runtime overhead when lockdep is disabled. With lockdep enabled, it ver=
ifies
+that the lock is only acquired in process context and never from softirq or
+hard IRQ context.
+
+On a PREEMPT_RT kernel, local_lock_t is implemented using a per-CPU spinlo=
ck_t,
+which provides safe local protection for per-CPU data while keeping the sy=
stem
+preemptible.
+
+Because spinlock_t on PREEMPT_RT does not disable preemption, it cannot be=
 used
+to protect per-CPU data by relying on implicit preemption disabling. If th=
is
+inherited preemption disabling is essential and if local_lock_t cannot be =
used
+due to performance constraints, brevity of the code, or abstraction bounda=
ries
+within an API then preempt_disable_nested() may be a suitable alternative.=
 On
+non-PREEMPT_RT kernels, it verifies with lockdep that preemption is already
+disabled. On PREEMPT_RT, it explicitly disables preemption.
+
+Timers
+------
+
+By default, an hrtimer is executed in hard interrupt context. The exceptio=
n is
+timers initialized with the HRTIMER_MODE_SOFT flag, which are executed in
+softirq context.
+
+On a PREEMPT_RT kernel, this behavior is reversed: hrtimers are executed in
+softirq context by default, typically within the ktimersd thread. This thr=
ead
+runs at the lowest real-time priority, ensuring it executes before any
+SCHED_OTHER tasks but does not interfere with higher-priority real-time
+threads. To explicitly request execution in hard interrupt context on
+PREEMPT_RT, the timer must be marked with the HRTIMER_MODE_HARD flag.
+
+Memory allocation
+-----------------
+
+The memory allocation APIs, such as kmalloc() and alloc_pages(), require a
+gfp_t flag to indicate the allocation context. On non-PREEMPT_RT kernels, =
it is
+necessary to use GFP_ATOMIC when allocating memory from interrupt context =
or
+from sections where preemption is disabled. This is because the allocator =
must
+not sleep in these contexts waiting for memory to become available.
+
+However, this approach does not work on PREEMPT_RT kernels. The memory
+allocator in PREEMPT_RT uses sleeping locks internally, which cannot be
+acquired when preemption is disabled. Fortunately, this is generally not a
+problem, because PREEMPT_RT moves most contexts that would traditionally r=
un
+with preemption or interrupts disabled into threaded context, where sleepi=
ng is
+allowed.
+
+What remains problematic is code that explicitly disables preemption or
+interrupts. In such cases, memory allocation must be performed outside the
+critical section.
+
+This restriction also applies to memory deallocation routines such as kfre=
e()
+and free_pages(), which may also involve internal locking and must not be
+called from non-preemptible contexts.
+
+IRQ work
+--------
+
+The irq_work API provides a mechanism to schedule a callback in interrupt
+context. It is designed for use in contexts where traditional scheduling i=
s not
+possible, such as from within NMI handlers or from inside the scheduler, w=
here
+using a workqueue would be unsafe.
+
+On non-PREEMPT_RT systems, all irq_work items are executed immediately in
+interrupt context. Items marked with IRQ_WORK_LAZY are deferred until the =
next
+timer tick but are still executed in interrupt context.
+
+On PREEMPT_RT systems, the execution model changes. Because irq_work callb=
acks
+may acquire sleeping locks or have unbounded execution time, they are hand=
led
+in thread context by a per-CPU irq_work kernel thread. This thread runs at=
 the
+lowest real-time priority, ensuring it executes before any SCHED_OTHER tas=
ks
+but does not interfere with higher-priority real-time threads.
+
+The exception are work items marked with IRQ_WORK_HARD_IRQ, which are still
+executed in hard interrupt context. Lazy items (IRQ_WORK_LAZY) continue to=
 be
+deferred until the next timer tick and are also executed by the irq_work/
+thread.
+
+RCU callbacks
+-------------
+
+RCU callbacks are invoked by default in softirq context. Their execution is
+important because, depending on the use case, they either free memory or e=
nsure
+progress in state transitions. Running these callbacks as part of the soft=
irq
+chain can lead to undesired situations, such as contention for CPU resourc=
es
+with other SCHED_OTHER tasks when executed within ksoftirqd.
+
+To avoid running callbacks in softirq context, the RCU subsystem provides a
+mechanism to execute them in process context instead. This behavior can be
+enabled by setting the boot command-line parameter rcutree.use_softirq=3D0=
. This
+setting is enforced in kernels configured with PREEMPT_RT.
+
+Spin until ready
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The "spin until ready" pattern involves repeatedly checking (spinning on) =
the
+state of a data structure until it becomes available. This pattern assumes=
 that
+preemption, soft interrupts, or interrupts are disabled. If the data struc=
ture
+is marked busy, it is presumed to be in use by another CPU, and spinning s=
hould
+eventually succeed as that CPU makes progress.
+
+Some examples are hrtimer_cancel() or timer_delete_sync(). These functions
+cancel timers that execute with interrupts or soft interrupts disabled. If=
 a
+thread attempts to cancel a timer and finds it active, spinning until the
+callback completes is safe because the callback can only run on another CP=
U and
+will eventually finish.
+
+On PREEMPT_RT kernels, however, timer callbacks run in thread context. This
+introduces a challenge: a higher-priority thread attempting to cancel the =
timer
+may preempt the timer callback thread. Since the scheduler cannot migrate =
the
+callback thread to another CPU due to affinity constraints, spinning can r=
esult
+in livelock even on multiprocessor systems.
+
+To avoid this, both the canceling and callback sides must use a handshake
+mechanism that supports priority inheritance. This allows the canceling th=
read
+to suspend until the callback completes, ensuring forward progress without
+risking livelock.
+
+In order to solve the problem at the API level, the sequence locks were ex=
tended
+to allow a proper handover between the the spinning reader and the maybe
+blocked writer.
+
+Sequence locks
+--------------
+
+Sequence counters and sequential locks are documented in
+Documentation/locking/seqlock.rst.
+
+The interface has been extended to ensure proper preemption states for the
+writer and spinning reader contexts. This is achieved by embedding the wri=
ter
+serialization lock directly into the sequence counter type, resulting in
+composite types such as seqcount_spinlock_t or seqcount_mutex_t.
+
+These composite types allow readers to detect an ongoing write and actively
+boost the writer=E2=80=99s priority to help it complete its update instead=
 of spinning
+and waiting for its completion.
+
+If the plain seqcount_t is used, extra care must be taken to synchronize t=
he
+reader with the writer during updates. The writer must ensure its update is
+serialized and non-preemptible relative to the reader. This cannot be achi=
eved
+using a regular spinlock_t because spinlock_t on PREEMPT_RT does not disab=
le
+preemption. In such cases, using seqcount_spinlock_t is the preferred solu=
tion.
+
+However, if there is no spinning involved i.e., if the reader only needs to
+detect whether a write has started and not serialize against it then using
+seqcount_t is reasonable.
diff --git a/Documentation/core-api/real-time/index.rst b/Documentation/cor=
e-api/real-time/index.rst
new file mode 100644
index 0000000000000..7e14c4ea3d592
--- /dev/null
+++ b/Documentation/core-api/real-time/index.rst
@@ -0,0 +1,16 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Real-time preemption
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+This documentation is intended for Linux kernel developers and contributors
+interested in the inner workings of PREEMPT_RT. It explains key concepts a=
nd
+the required changes compared to a non-PREEMPT_RT configuration.
+
+.. toctree::
+   :maxdepth: 2
+
+   theory
+   differences
+   architecture-porting
diff --git a/Documentation/core-api/real-time/theory.rst b/Documentation/co=
re-api/real-time/theory.rst
new file mode 100644
index 0000000000000..43d0120737f87
--- /dev/null
+++ b/Documentation/core-api/real-time/theory.rst
@@ -0,0 +1,116 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Theory of operation
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+Preface
+=3D=3D=3D=3D=3D=3D=3D
+
+PREEMPT_RT transforms the Linux kernel into a real-time kernel. It achieves
+this by replacing locking primitives, such as spinlock_t, with a preemptib=
le
+and priority-inheritance aware implementation known as rtmutex, and by enf=
orcing
+the use of threaded interrupts. As a result, the kernel becomes fully
+preemptible, with the exception of a few critical code paths, including en=
try
+code, the scheduler, and low-level interrupt handling routines.
+
+This transformation places the majority of kernel execution contexts under=
 the
+control of the scheduler and significantly increasing the number of preemp=
tion
+points. Consequently, it reduces the latency between a high-priority task
+becoming runnable and its actual execution on the CPU.
+
+Scheduling
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The core principles of Linux scheduling and the associated user-space API =
are
+documented in the man page sched(7)
+`sched(7) <https://man7.org/linux/man-pages/man7/sched.7.html>`_.
+By default, the Linux kernel uses the SCHED_OTHER scheduling policy. Under
+this policy, a task is preempted when the scheduler determines that it has
+consumed a fair share of CPU time relative to other runnable tasks. Howeve=
r,
+the policy does not guarantee immediate preemption when a new SCHED_OTHER =
task
+becomes runnable. The currently running task may continue executing.
+
+This behavior differs from that of real-time scheduling policies such as
+SCHED_FIFO. When a task with a real-time policy becomes runnable, the
+scheduler immediately selects it for execution if it has a higher priority=
 than
+the currently running task. The task continues to run until it voluntarily
+yields the CPU, typically by blocking on an event.
+
+Sleeping spin locks
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The various lock types and their behavior under real-time configurations a=
re
+described in detail in Documentation/locking/locktypes.rst.
+In a non-PREEMPT_RT configuration, a spinlock_t is acquired by first disab=
ling
+preemption and then actively spinning until the lock becomes available. On=
ce
+the lock is released, preemption is enabled. From a real-time perspective,
+this approach is undesirable because disabling preemption prevents the
+scheduler from switching to a higher-priority task, potentially increasing
+latency.
+
+To address this, PREEMPT_RT replaces spinning locks with sleeping spin loc=
ks
+that do not disable preemption. On PREEMPT_RT, spinlock_t is implemented u=
sing
+rtmutex. Instead of spinning, a task attempting to acquire a contended lock
+disables CPU migration, donates its priority to the lock owner (priority
+inheritance), and voluntarily schedules out while waiting for the lock to
+become available.
+
+Disabling CPU migration provides the same effect as disabling preemption, =
while
+still allowing preemption and ensuring that the task continues to run on t=
he
+same CPU while holding a sleeping lock.
+
+Priority inheritance
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Lock types such as spinlock_t and mutex_t in a PREEMPT_RT enabled kernel a=
re
+implemented on top of rtmutex, which provides support for priority inherit=
ance
+(PI). When a task blocks on such a lock, the PI mechanism temporarily
+propagates the blocked task=E2=80=99s scheduling parameters to the lock ow=
ner.
+
+For example, if a SCHED_FIFO task A blocks on a lock currently held by a
+SCHED_OTHER task B, task A=E2=80=99s scheduling policy and priority are te=
mporarily
+inherited by task B. After this inheritance, task A is put to sleep while
+waiting for the lock, and task B effectively becomes the highest-priority =
task
+in the system. This allows B to continue executing, make progress, and
+eventually release the lock.
+
+Once B releases the lock, it reverts to its original scheduling parameters=
, and
+task A can resume execution.
+
+Threaded interrupts
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Interrupt handlers are another source of code that executes with preemption
+disabled and outside the control of the scheduler. To bring interrupt hand=
ling
+under scheduler control, PREEMPT_RT enforces threaded interrupt handlers.
+
+With forced threading, interrupt handling is split into two stages. The fi=
rst
+stage, the primary handler, is executed in IRQ context with interrupts dis=
abled.
+Its sole responsibility is to wake the associated threaded handler. The se=
cond
+stage, the threaded handler, is the function passed to request_irq() as the
+interrupt handler. It runs in process context, scheduled by the kernel.
+
+From waking the interrupt thread until threaded handling is completed, the
+interrupt source is masked in the interrupt controller. This ensures that =
the
+device interrupt remains pending but does not retrigger the CPU, allowing =
the
+system to exit IRQ context and handle the interrupt in a scheduled thread.
+
+By default, the threaded handler executes with the SCHED_FIFO scheduling p=
olicy
+and a priority of 50 (MAX_RT_PRIO / 2), which is midway between the minimu=
m and
+maximum real-time priorities.
+
+If the threaded interrupt handler raises any soft interrupts during its
+execution, those soft interrupt routines are invoked after the threaded ha=
ndler
+completes, within the same thread. Preemption remains enabled during the
+execution of the soft interrupt handler.
+
+Summary
+=3D=3D=3D=3D=3D=3D=3D
+
+By using sleeping locks and forced-threaded interrupts, PREEMPT_RT
+significantly reduces sections of code where interrupts or preemption is
+disabled, allowing the scheduler to preempt the current execution context =
and
+switch to a higher-priority task.
--=20
2.50.1

