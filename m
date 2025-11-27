Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10B133710C
	for <linux-rt-devel@lists.linux.dev>; Thu, 27 Nov 2025 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764258232; cv=none; b=YO+kqoA2sgCO85tQBZvumGSl8bVj8+TKU5/nH+9UsE0Q+vDUG/sm1GQcwvVuhjBpyxzl9gScT9z2yot7m2HrGRn3t/LT/HhggLp3LMf55+IFoTWvoP0OTf0agixst3rogkklqMdOhzBbpJ83DBISPnqOpNOcQXVglkucTT/6AA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764258232; c=relaxed/simple;
	bh=GjDb9eHuuQEAe4KDiBAWss58vZJfQtr/9/mSEy3KnR0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcqxoG3ROf3dgZtkxJbU4zy6ItKxAhsgry1CiYpZa1o1EsnshzMHDYrfWBLVIxXD8pTVBZEK5uBr7x7M0aCW5ZIAUAAYin36zxQuDNRC3H7yanglDygcD/NWxhU4Ednwhv3TPN8jFslVJmq2QqRGsfKGjL4PeCSNnwlquBhqQZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hgtOIcx1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OrSa4k/P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hgtOIcx1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OrSa4k/P"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764258225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYgf4nZtWQM3LRjvZg+J60JADkfUOjDC+9vpdLFPca4=;
	b=hgtOIcx11EZUQFMr29+GpYasvQ2qCwGmTeHhIbT1HgL6uZfqt2A2+gs1Sfej5WYw+LQTeK
	P+bS6yCw2O0aoqCNx2xVQS1QAFYYEq3wRZxmeSo6eo7Ah1mcEZPUU28ZzAjg/Kd7zali/S
	s80GtxNGkboy9MSNGTuJVeO2DpqWUwXdqY3zD2Bf/7JpJwkzvLL6AZWtV0uxAe5at3xeCB
	aiHGViBG/qErdB7eYg7tzVTlyl9l60Dr7sb6umF8SDH55vWqmuvvnPuV0HogMXEBmTPCaj
	jpxkCaewirfryB2yrT2q4aA3BK/qtTB6U0w8nvnEIWGyZ8lpS2hKR8NJbvJkvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764258225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYgf4nZtWQM3LRjvZg+J60JADkfUOjDC+9vpdLFPca4=;
	b=OrSa4k/PW2qNc3SRkgLz0/g30CwL/qdZePlnSeid93lRC8LXFgVJNa4PAfMR0TD44GuYsh
	wowAfYGl08TAjaCQ==
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: Clark Williams <clrkwllms@kernel.org>,
	John Ogness <john.ogness@linutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 1/3] Documentation: Add some hardware hints for real-time
Date: Thu, 27 Nov 2025 16:43:41 +0100
Message-ID: <20251127154343.292156-2-bigeasy@linutronix.de>
In-Reply-To: <20251127154343.292156-1-bigeasy@linutronix.de>
References: <20251127154343.292156-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some thoughts on hardware that is used for real-time workload. Certainly
not complete but should cover some of the import topics such as:

- Main memory, caches and the possiblie control given by the hardware.
- What could happen by putting critical hardware behind USB or VirtIO.
- Allowing real-time tasks to consume the CPU entirely without giving
  the system some time to breath.
- Networking with what the kernel provides.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/core-api/real-time/hardware.rst | 132 ++++++++++++++++++
 Documentation/core-api/real-time/index.rst    |   1 +
 2 files changed, 133 insertions(+)
 create mode 100644 Documentation/core-api/real-time/hardware.rst

diff --git a/Documentation/core-api/real-time/hardware.rst b/Documentation/=
core-api/real-time/hardware.rst
new file mode 100644
index 0000000000000..19f9bb3786e03
--- /dev/null
+++ b/Documentation/core-api/real-time/hardware.rst
@@ -0,0 +1,132 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+Considering hardware
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+:Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
+
+The way a workload is handled can be influenced by the hardware it runs on.
+Key components include the CPU, memory, and the buses that connect them.
+These resources are shared among all applications on the system.
+As a result, heavy utilization of one resource by a single application
+can affect the deterministic handling of workloads in other applications.
+
+Below is a brief overview.
+
+System memory and cache
+-----------------------
+
+Main memory and the associated caches are the most common shared resources=
 among
+tasks in a system. One task can dominate the available caches, forcing ano=
ther
+task to wait until a cache line is written back to main memory before it c=
an
+proceed. The impact of this contention varies based on write patterns and =
the
+size of the caches available. Larger caches may reduce stalls because more=
 lines
+can be buffered before being written back. Conversely, certain write patte=
rns
+may trigger the cache controller to flush many lines at once, causing
+applications to stall until the operation completes.
+
+This issue can be partly mitigated if applications do not share the same C=
PU
+cache. The kernel is aware of the cache topology and exports this informat=
ion to
+user space. Tools such as **lstopo** from the Portable Hardware Locality (=
hwloc)
+project (https://www.open-mpi.org/projects/hwloc/) can visualize the hiera=
rchy.
+
+Avoiding shared L2 or L3 caches is not always possible. Even when cache sh=
aring
+is minimized, bottlenecks can still occur when accessing system memory. Me=
mory
+is used not only by the CPU but also by peripheral devices via DMA, such as
+graphics cards or network adapters.
+
+In some cases, cache and memory bottlenecks can be controlled if the hardw=
are
+provides the necessary support. On x86 systems, Intel offers Cache Allocat=
ion
+Technology (CAT), which enables cache partitioning among applications and
+provides control over the interconnect. AMD provides similar functionality=
 under
+Platform Quality of Service (PQoS). On Arm64, the equivalent is Memory
+System Resource Partitioning and Monitoring (MPAM).
+
+These features can be configured through the Linux Resource Control interf=
ace.
+For details, see Documentation/filesystems/resctrl.rst.
+
+The perf tool can be used to monitor cache behavior. It can analyze
+cache misses of an application and compare how they change under
+different workloads on a neighboring CPU. Even more powerful, the perf
+c2c tool can help identify cache-to-cache issues, where multiple CPU
+cores repeatedly access and modify data on the same cache line.
+
+Hardware buses
+--------------
+
+Real-time systems often need to access hardware directly to perform their =
work.
+Any latency in this process is undesirable, as it can affect the outcome o=
f the
+task. For example, on an I/O bus, a changed output may not become immediat=
ely
+visible but instead appear with variable delay depending on the latency of=
 the
+bus used for communication.
+
+A bus such as PCI is relatively simple because register accesses are routed
+directly to the connected device. In the worst case, a read operation stal=
ls the
+CPU until the device responds.
+
+A bus such as USB is more complex, involving multiple layers. A register r=
ead
+or write is wrapped in a USB Request Block (URB), which is then sent by the
+USB host controller to the device. Timing and latency are influenced by the
+underlying USB bus. Requests cannot be sent immediately; they must align w=
ith
+the next frame boundary according to the endpoint type and the host contro=
ller's
+scheduling rules. This can introduce delays and additional latency. For ex=
ample,
+a network device connected via USB may still deliver sufficient throughput=
, but
+the added latency when sending or receiving packets may fail to meet the
+requirements of certain real-time use cases.
+
+Additional restrictions on bus latency can arise from power management. For
+instance, PCIe with Active State Power Management (ASPM) enabled can suspe=
nd
+the link between the device and the host. While this behavior is beneficia=
l for
+power savings, it delays device access and adds latency to responses. This=
 issue
+is not limited to PCIe; internal buses within a System-on-Chip (SoC) can a=
lso be
+affected by power management mechanisms.
+
+Virtualization
+--------------
+
+In a virtualized environment such as KVM, each guest CPU is represented as=
 a
+thread on the host. If such a thread runs with real-time priority, the sys=
tem
+should be tested to confirm it can sustain this behavior over extended per=
iods.
+Because of its priority, the thread will not be preempted by lower-priority
+threads (such as SCHED_OTHER), which may then receive no CPU time. This can
+cause problems if a lower-priority thread is pinned to a CPU already occup=
ied by
+a real-time task and unable to make progress. Even if a CPU has been isola=
ted,
+the system may still (accidentally) start a per=E2=80=91CPU thread on that=
 CPU.
+Ensuring that a guest CPU goes idle is difficult, as it requires avoiding =
both
+task scheduling and interrupt handling. Furthermore, if the guest CPU does=
 go
+idle but the guest system is booted with the option **idle=3Dpoll**, the g=
uest
+CPU will never enter an idle state and will instead spin until an event
+arrives.
+
+Device handling introduces additional considerations. Emulated PCI devices=
 or
+VirtIO devices require a counterpart on the host to complete requests. This
+adds latency because the host must intercept and either process the request
+directly or schedule a thread for its completion. These delays can be avoi=
ded if
+the required PCI device is passed directly through to the guest. Some devi=
ces,
+such as networking or storage controllers, support the PCIe SR-IOV feature.
+SR-IOV allows a single PCIe device to be divided into multiple virtual fun=
ctions,
+which can then be assigned to different guests.
+
+Networking
+----------
+
+For low-latency networking, the full networking stack may be undesirable, =
as it
+can introduce additional sources of delay. In this context, XDP can be used
+as a shortcut to bypass much of the stack while still relying on the kerne=
l's
+network driver.
+
+The requirements are that the network driver must support XDP- preferably =
using
+an "skb pool" and that the application must use an XDP socket. Additional
+configuration may involve BPF filters, tuning networking queues, or config=
uring
+qdiscs for time-based transmission. These techniques are often
+applied in Time-Sensitive Networking (TSN) environments.
+
+Documenting all required steps exceeds the scope of this text. For detailed
+guidance, see the TSN documentation at https://tsn.readthedocs.io.
+
+Another useful resource is the Linux Real-Time Communication Testbench
+https://github.com/Linutronix/RTC-Testbench.
+The goal of this project is to validate real-time network communication. I=
t can
+be thought of as a "cyclictest" for networking and also serves as a starti=
ng
+point for application development.
diff --git a/Documentation/core-api/real-time/index.rst b/Documentation/cor=
e-api/real-time/index.rst
index 7e14c4ea3d592..f08d2395a22c9 100644
--- a/Documentation/core-api/real-time/index.rst
+++ b/Documentation/core-api/real-time/index.rst
@@ -13,4 +13,5 @@ the required changes compared to a non-PREEMPT_RT configu=
ration.
=20
    theory
    differences
+   hardware
    architecture-porting
--=20
2.51.0

